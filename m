Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084DFC5AD7B
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 18:35:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D24E810E96C;
	Mon, 10 Aug 2026 18:35:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="KSWjp/QX";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D97C410E96C
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 18:35:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786386905; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Xdze7+6+lAmudxeU2EEGTDqnbwoExe7UW/F01OINVDIvnDUiYY3gEySUIzarfttHfz1StKBzcUXL8yX0SeKDldLpDEzT5tF4eN220EpvcNb23Ns4IW+wxs/27HOysZxVUHYpqCEJ1A78LyiaEYfH6mtXJ0KlyDNnmgqTsVGNGUg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786386905;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=wuiGyY1XGfwjwsb2Pw2tUN8ltgrhxl1qHkj0d5/SIUg=; 
 b=P7I/Pjg7ddD1xXHvM9kD9h3DmnB3+97E1DYQ0mGefQOiJmxMT5rzYBmUZAK+iH/g2Z4gPvVq66C6diAmOhvsJqRlDU65yXhTS1mWt2hrfzR6ZIvySfiKcXSAVKCu7Q9EdQsDo7XygRWjBPMe1lDLXP7cT1sNykNSsMn9UKCoLdA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786386905; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=wuiGyY1XGfwjwsb2Pw2tUN8ltgrhxl1qHkj0d5/SIUg=;
 b=KSWjp/QXN0ha6bqxfYdddC6eJ+y4VeXzWqltMZN0iW+AApN7asc+yHoS6cd7mhiJ
 SoAQUT+HLuf8TsxyD1Tmxu3TzVM0tggo+zurz6u+kGbzWZ66N/YrA03JtFVnnl/cp0b
 74opUQ6+cIfy/CMePZKuBFuWzI45Qr5ue90kFYUM=
Received: by mx.zohomail.com with SMTPS id 1786386903952369.9569936119061;
 Mon, 10 Aug 2026 11:35:03 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3 2/3] drm/tyr: clear stale IRQ state before soft reset
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260708114358.957305-3-work@onurozkan.dev>
Date: Mon, 10 Aug 2026 15:34:45 -0300
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dakr@kernel.org, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu
Content-Transfer-Encoding: quoted-printable
Message-Id: <8E4EA286-887C-4B3D-8AE0-F83E2C838B0A@collabora.com>
References: <20260708114358.957305-1-work@onurozkan.dev>
 <20260708114358.957305-3-work@onurozkan.dev>
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



> On 8 Jul 2026, at 08:43, Onur =C3=96zkan <work@onurozkan.dev> wrote:
>=20
> Previous reset may leave the reset completed IRQ set which can make =
the
> poll return too early.
>=20
> Clear the IRQ first so the driver waits for the current reset to
> complete.
>=20
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> ---
> drivers/gpu/drm/tyr/driver.rs | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/tyr/driver.rs =
b/drivers/gpu/drm/tyr/driver.rs
> index c5063b2be94d..90d6cd988cd2 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -86,6 +86,9 @@ pub(crate) struct TyrDrmRegistrationData<'bound> {
> }
>=20
> fn issue_soft_reset(dev: &Device, iomem: &IoMem<'_>) -> Result {
> +    // Clear any stale reset IRQ state before issuing a new soft =
reset.
> +    =
iomem.write_reg(GPU_IRQ_CLEAR::zeroed().with_reset_completed(true));
> +
>     iomem.write_reg(GPU_COMMAND::reset(ResetMode::SoftReset));
>=20
>     poll::read_poll_timeout(
> --=20
> 2.51.2
>=20

Little has changed from v1 IIUC, where Boris gave his r-b already. I =
think
you can carry over the tag.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

