Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B974CD8CAC
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:29:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 656E810E1A8;
	Tue,  9 Jun 2026 08:29:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FUipCiG+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 828FB10E1A8
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 08:29:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EDD8E601E6;
 Tue,  9 Jun 2026 08:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943A71F00898;
 Tue,  9 Jun 2026 08:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780993759;
 bh=gchQjwKtewHdORlOBqADgZdq2U23SgAXQd05XHbvenM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FUipCiG+i8Da526AjJVD9AwXRAh87HhayGx5IXKdzYr96POG00JZHYLF3LBwddeBj
 AzaDcPj/yJzFSgAH7b3gFVM1P+E31pZtr/dK+nr5TfhxiNgWTmQZXlO7oBexImKFfM
 w6gn1LOvrX+1efySwKwcEV/yxubJ3VqpSUhtjC2JciCGSrCykwpAT619BRXkW9bspR
 VGxKgfcMzUcUgbWV0Qr+r7Q8994YL3GT51uQ2KAlRN9Fv7NmtfR6P0tLha/x6msYME
 OjeSwVkpp7+0oDjpk7FMwjSy0XypqJ55ZWw0pHB0qz9xru4dVeu1GeLEuNo4KrjUCu
 mvl3HWFLPyriA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] gpu: host1x: Annotate intentional syncpoint
 wrap-around
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609-b4-host1x-small-fixes-a-v1-6-7c1131c0b3ad@nvidia.com>
References: <20260609-b4-host1x-small-fixes-a-v1-6-7c1131c0b3ad@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 08:29:18 +0000
Message-Id: <20260609082919.943A71F00898@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Direct `<` comparison of wrap-around syncpoint values leads to inc=
orrect evaluation of job completion status during timeout recovery.
--

commit 00ebce8e032b66ba3bfbcd7a17200301254bdb05
Author: Mikko Perttunen <mperttunen@nvidia.com>

gpu: host1x: Annotate intentional syncpoint wrap-around

Host1x syncpoints are 32-bit counters that roll over by design. This commit
uses wrapping_* functions whenever arithmetic is done on syncpoint values to
make this explicit in the code.

> diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
> index ba2e572567c03..f6d3db2c8c395 100644
> --- a/drivers/gpu/host1x/cdma.c
> +++ b/drivers/gpu/host1x/cdma.c

[ ... ]

> @@ -419,7 +420,7 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma=
 *cdma,
>  		/* won't need a timeout when replayed */
>  		job->timeout =3D 0;
> =20
> -		syncpt_incrs =3D job->syncpt_end - syncpt_val;
> +		syncpt_incrs =3D wrapping_sub(u32, job->syncpt_end, syncpt_val);

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem earlier in
this same function regarding syncpt_val and job->syncpt_end wrap-around.

In host1x_cdma_update_sync_queue(), the loop over the sync_queue uses a
direct comparison to check if a job is uncompleted:

	list_for_each_entry(job, &cdma->sync_queue, list) {
		if (syncpt_val < job->syncpt_end) {

			if (!list_is_last(&job->list, &cdma->sync_queue))
				next_job =3D list_next_entry(job, list);

			goto syncpt_incr;
		}

If syncpt_val is near the maximum value and job->syncpt_end has wrapped
around to a small value, the condition evaluates to false. This makes the
recovery logic incorrectly assume the job has completed, skipping the CPU
increments and resuming the hardware channel without bypassing the failed
job.

Should that comparison also be updated to handle wrap-around conditions
safely?

>  		dev_dbg(dev, "%s: CPU incr (%d)\n", __func__, syncpt_incrs);
> =20
>  		host1x_job_dump(dev, job);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-b4-host1x-=
small-fixes-a-v1-0-7c1131c0b3ad@nvidia.com?part=3D6
