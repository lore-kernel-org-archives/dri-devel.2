Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63A4C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFEB710F30E;
	Fri, 21 Aug 2026 15:31:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="jaqD0xxi";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DE7F10F30E
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:31:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787326283; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EST4mSCi/5S9V9thzlzlvenSyfADllx/U/IKWVEk+4tqw4UcAKeOZIw4gbUdHQSeg8ymvUlba10TOTb6ePgdBBEB/8hlzFtkmT7lUy1btOQabOjRbGtoBvCYHxNMS2BWWyXVULKbs5cCu9wHHBnjoMs4Io3qK3lBxrU840cZL10=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787326283;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=+041lIFhhTpsX+FiqppUIWOEJNwqeo2etbhtupMqTJ0=; 
 b=ZiJc4KtgBb0A6bUMO25p90Ww9yo902kmpUBxER8lxE5cps38S0HknvcaEiuLNoDf2mWS3b68H9SMRWIsBV3vaBFwFSCMy5E9nbxno6+5FshP2zxa805784zOs2TkfHj9nYTLI6ljUrwJKhaVW4JuBnKpoAXg4W21npph6oayR4g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787326283; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=+041lIFhhTpsX+FiqppUIWOEJNwqeo2etbhtupMqTJ0=;
 b=jaqD0xxifGdlk44Q3N/1H6i92dysXyemTIjn9gJAHUKOTm41j49LFhf+CjRe//KW
 46cbsZ0ZiDpIhH9Cbg3yQl2ILc3zFNxVaK7lsKDoic5S4jn+a+cfHCEVpb045SuPeIg
 5UrxiaRMii2aykUzQNQQuPyZNm+Z+0CLbLHe/UQw=
Received: by mx.zohomail.com with SMTPS id 1787326281210413.5754291736158;
 Fri, 21 Aug 2026 08:31:21 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 2/3] drm/tyr: add GPU reset infrastructure
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260819-tyr-reset-impl-v6-2-7b4e1e041fe5@onurozkan.dev>
Date: Fri, 21 Aug 2026 12:31:03 -0300
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dakr@kernel.org, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu
Content-Transfer-Encoding: quoted-printable
Message-Id: <653D47F5-0AF3-44B5-9896-F0AA81F67B61@collabora.com>
References: <20260819-tyr-reset-impl-v6-0-7b4e1e041fe5@onurozkan.dev>
 <20260819-tyr-reset-impl-v6-2-7b4e1e041fe5@onurozkan.dev>
To: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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

Hi Onur,

> On 19 Aug 2026, at 15:45, Onur =C3=96zkan <work@onurozkan.dev> wrote:
>=20
> Add support for scheduling GPU resets on a dedicated workqueue. Track
> the reset state to avoid queueing another reset while one is already
> pending or in progress.
>=20
> Use an SRCU based gate with mutex-protected reader admission to block
> hardware accesses while reset work runs and wait for current users
> before resetting.
>=20
> Stop new reset requests during teardown and drain any queued or =
running
> reset work before releasing the device resources.
>=20
> This is the initial reset infrastructure only. It is not wired to a =
reset
> source yet as those will follow in separate work.
>=20
> Link: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/28
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>

I=E2=80=99d use dev_info instead, I don=E2=80=99t think a reset belongs =
in dev_dbg.

Otherwise, this looks good to go from my POV.

Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=
