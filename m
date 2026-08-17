Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9D0C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 17:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 852E388FBD;
	Mon, 17 Aug 2026 17:06:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="GRd+muIu";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7271D88FBD
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 17:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1786986364; x=1787591164; i=markus.elfring@web.de;
 bh=0WlRIYMqV+QzOsk+k7yQ+OVEfOyYnFY55nTxeLCU2NQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GRd+muIuYKtJhvTA4ReZ37VPgdk1VmMm35i2au5CcgYmDv5e++6YFQfdbVgmq2+P
 Zo1Wfu40KKlfK9+iyDUnJ9y/Wvkc23GT865rJ6Pcy8p1b75YGPP8kKMDBg6S82KmU
 vOf9N080eb4/kEhvC+KcA+qDtP5PhZUmBTRJ6SbXI0JYEinZVreuU3tkEjpcEV70X
 InWM0LSqfpkZN/rWRpltUMlgYQ6DFwoMuiNkwmAuXv+K4b6coXQi7DPicc0BA2ywY
 sajABCH8E6FznpIcS35lUP7jMOWfAmpScd/SEKH9O8YUj2M6V5kcaUn89dcvXRFXz
 +bpL+kp33GyKTS8jvw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7ux6-1wzqGX3ltS-003FPM; Mon, 17
 Aug 2026 19:06:03 +0200
Message-ID: <3c13705a-6d04-4058-a03e-cacd91b06e93@web.de>
Date: Mon, 17 Aug 2026 19:06:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] drm/rocket: Keep scheduler allocation in
 rocket_file_priv
To: Triet Hoang <triet.hoang.dev@gmail.com>, dri-devel@lists.freedesktop.org, 
 Oded Gabbay <ogabbay@kernel.org>, Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Igor Paunovic <royalnet026@gmail.com>
References: <20260817093009.22359-1-royalnet026@gmail.com>
 <20260817140110.148873-1-89897892+HMTCT@users.noreply.github.com>
 <20260817140110.148873-2-89897892+HMTCT@users.noreply.github.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260817140110.148873-2-89897892+HMTCT@users.noreply.github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R1Z5g/CmO9/fpcjyvF2CM1PJNwNCzBjc0yoihokh61waYenjH69
 XmcjmvBClZnAAFgFim1g1W+VEVVqbCbu9xAFKPKl5pyijHjUkaAt5UhRJBbOo1OSt8tNVvV
 DgBWHm6d8X1YPokkCTB5O0bYYVG8QnX12dq1Vcf9nTCPBp85h1yl2jm4kSLwdcl9caEDprp
 2yYgKJVUcG+oj3HIo1Apg==
UI-OutboundReport: notjunk:1;M01:P0:+nQsOgxR6Cs=;WKa1VG/Y79rY2lOGwn8wGcI/BMc
 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
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

=E2=80=A6
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -514,8 +514,11 @@ int rocket_job_open(struct rocket_file_priv *rocket=
_priv)
>  				    DRM_SCHED_PRIORITY_NORMAL,
>  				    scheds,
>  				    rdev->num_cores, NULL);
> +
>  	if (WARN_ON(ret))
>  		kfree(scheds);
=E2=80=A6

Why do you think that an additional blank would be helpful at this place?

Regards,
Markus
