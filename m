Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BEFC5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 21:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9920710F3C4;
	Fri, 21 Aug 2026 21:59:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="DiEA8sNy";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4F4D10E359
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 21:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787349572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tYY+VYhzG1oHVnCCsnrZL1hda9ZFN1K71JsN0AuTTHI=;
 b=DiEA8sNy/kuT7LHkAU71ULAnRbBLVBaNI8QhNzkXIJZYpp2T2o5QL30F58n7bMXL3YZD2E
 G80++zIE5ytShcQdQYSTUD2VsTYTInqe8WiWp5GXAlXRQE55YYBA+zCzx/tpV5q9hz740K
 CYC+8ZYQan1bk17IcAVPnLKTQR2iar8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-6ih3bt5UNSycwc16NLOt0g-1; Fri, 21 Aug 2026 17:59:31 -0400
X-MC-Unique: 6ih3bt5UNSycwc16NLOt0g-1
X-Mimecast-MFC-AGG-ID: 6ih3bt5UNSycwc16NLOt0g_1787349571
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-936aa3d9dfbso150486685a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787349571; x=1787954371;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Yu+hOZT2DZL8hLRcYSAFyvPiNjPMHm+BvocQ7hwJTWc=;
 b=sTHvUI3e7EJrGwIHAtyLvCzjtNf0twfYPXDbiBKnmGPoXckwXQDao634jrr17e1ndt
 vFyJwUIKP/WHx80Ge+nZ4fT0Hs/25cKgcfiprRIMZoWnF05Y0d9gAY3xevElSBodr3SE
 xX496VsDMJdNpTo+SPOaYv82yEMfA81ISmK3drXYBwuB3YWTNQ3jSpl5XLgDwf1TpAcB
 NRejue/YrwhHgyLTHUp37gt2CBm/K7eGCYZEUgw/j4tsc+45kOLLi89j5QpNJ7u5uWks
 KA+YgvV/59TPpohpCtHVJm3EOpVpNWvWAg2Ng+SCWNVNyaIxLczrLqkqmkY1ZLUuuFkA
 2eKA==
X-Gm-Message-State: AFuF++nwuWQcwRvv1TVqp3IE/tXYGti0uoLjb7D9/LFP0bSxcKmknv2F
 z9otlYvifC5bdYj9F33UiujNjEgzlp0AKkJV+ew9L+Zaeaz0bNhSYzsFnAAhd/tQiBBlvOR3VFb
 EsDcXwgmle+CCFO72s54KjdXs+RrxeI+o939AofVaSI9tM65vnmbOLMDbhmFl7T5gKfkyZA==
X-Gm-Gg: AR+sD134OMXoGlgZSEBIALkVJ4AA7KeWZfPHDDHDTRsTWk250qDzWPWC+TzpBTYhtyC
 yWH1ODtoY93HWsFX69e/z5+01FpsmaEpospUsNeeKb3qrXYRyP+n1WZusxK+d+UZM1f+MI7dkbi
 30ZVzsRPHViT9FmrNeU0eVEVBHUZ67Rge8RM9HZmQKsleFMnEzMqynOfV6YDZm5yPEgZfm3Zkvn
 YqMlSEPv9+1WDmQxFS7fprrx0/u6LKIcfmFuO3U22WCT6kqs0tG+Dcjygvq0QnlI8L17sAKZlfl
 8BXeyt/+Jn5jRJUGcy/nNdFygzXUtBqf7ku6B5AV755AXf/C7AJeiAm76+roa3+TCn+mjW2K
X-Received: by 2002:a05:620a:288b:b0:936:51af:1de0 with SMTP id
 af79cd13be357-937395f23d9mr843719685a.47.1787349570851; 
 Fri, 21 Aug 2026 14:59:30 -0700 (PDT)
X-Received: by 2002:a05:620a:288b:b0:936:51af:1de0 with SMTP id
 af79cd13be357-937395f23d9mr843716385a.47.1787349570425; 
 Fri, 21 Aug 2026 14:59:30 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93749adeee6sm7807585a.15.2026.08.21.14.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 14:59:29 -0700 (PDT)
Message-ID: <66d7cd7ee0a94e01ccb559a36178497ae2d806ad.camel@redhat.com>
Subject: Re: [PATCH v2 05/10] drm/nouveau/disp: fix HDMI GCP AVMute register
 offsets on GB20x
From: lyude@redhat.com
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Mary
 Guillemard <mary@mary.zone>, 	nouveau@lists.freedesktop.org
Date: Fri, 21 Aug 2026 17:59:28 -0400
In-Reply-To: <20260820164929.17117-6-mohamedahmedegypt2001@gmail.com>
References: <20260820164929.17117-1-mohamedahmedegypt2001@gmail.com>
 <20260820164929.17117-6-mohamedahmedegypt2001@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cRgbx2X0MfdfEaDgBOowZdf3Gs3qxvyixlKHW6pQfqo_1787349571
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Code-wise this looks totally fine, but I'm not actually getting any
audio on my local GB206 setup. Is this expected, e.g. will we need more
work to actually get it working?

On Thu, 2026-08-20 at 20:49 +0400, Mohamed Ahmed wrote:
> The GSP path brackets audio enablement with a General Control Packet
> AVMute toggle. r535_sor_hdmi_audio() calls the gsp.hdmi_gcp hook,
> which
> every chip so far serves with tu102_sor_hdmi_gcp() and the legacy GCP
> unit at 0x6f00c0/0x6f00cc. On GB20x the SF packet units were
> compacted
> and the old generic and VSI units are gone (ACR keeps slot 2) and the
> GCP unit moved from slot 3 to slot 1 (control 0x6f0040 and subpack
> 0x6f004c from NVIDIA's published clc971.h. The same offsets are also
> used by OpenRM's hdmiWriteGeneralCtrlPacketC871() on these chips).
> The
> old addresses are reserved on GB20x, so the AVMute writes were silent
> no-ops and mitigated only by the equivalent GCP r535_sor_hdmi_audio()
> already sends through the SET_OD_PACKET RM control.
>=20
> Add a GB20x GCP writer using the new offsets and hook it into
> gb202_gsp_disp, keeping the direct MMIO path in sync with the
> hardware
> as on earlier chips.
>=20
> Only SB0 (the AVMute bit) is written. On NVD5.0 the subpack register
> also
> carries SB1_CTRL (bit 24), which selects where the deep-color CD/PP
> fields are generated (hardware or from the driver, with the default
> being
> HW). hdmiWriteGeneralCtrlPacketC871() likewise writes only SB0-SB2.
>=20
> Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
> ---
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/disp/gb202.c=C2=A0 | 20
> ++++++++++++++++++-
> =C2=A01 file changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
> index fa83aee35ae7..4863b2b36db0 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
> @@ -65,6 +65,24 @@ gb202_sor_hdmi_infoframe_vsi(struct nvkm_ior *ior,
> int head, void *data, u32 siz
> =C2=A0=09nvkm_wr32(device, 0x6f03f8 + hoff, 0x00000002);
> =C2=A0}
> =C2=A0
> +/* General Control Packet AVMute bracket. The GCP unit moved to slot
> 1 on
> + * NVD5.0. Only SB0 (the AVMute bit) is ours to write so we must not
> do a
> + * full write here: SB1 carries the deep-color CD/PP fields, and
> SB1_CTRL
> + * (bit 24, new with clc871.h) controls where their generation
> happens (HW
> + * or driver) on these chips, with the default being HW.
> + */
> +static void
> +gb202_sor_hdmi_gcp(struct nvkm_ior *sor, int head, bool enable)
> +{
> +=09struct nvkm_device *device =3D sor->disp-
> >engine.subdev.device;
> +=09const u32 hdmi =3D head * 0x400;
> +
> +=09nvkm_mask(device, 0x6f0040 + hdmi, 0x00000001, 0x00000000);
> +=09nvkm_mask(device, 0x6f004c + hdmi, 0x000000ff, !enable ?
> 0x00000001 :
> +=09=09=09=09=09=09=09=09
> 0x00000010);
> +=09nvkm_mask(device, 0x6f0040 + hdmi, 0x00000001, 0x00000001);
> +}
> +
> =C2=A0/* GB20x is GSP-only. This table supplies the register programming
> the
> =C2=A0 * GSP-RM display path needs from the chip.
> =C2=A0 */
> @@ -77,7 +95,7 @@ gb202_gsp_disp =3D {
> =C2=A0=09.gsp.head_rgpos =3D gv100_head_rgpos,
> =C2=A0=09.gsp.vblank_get =3D tu102_head_vblank_get,
> =C2=A0=09.gsp.vblank_put =3D tu102_head_vblank_put,
> -=09.gsp.hdmi_gcp =3D tu102_sor_hdmi_gcp,
> +=09.gsp.hdmi_gcp =3D gb202_sor_hdmi_gcp,
> =C2=A0=09/* The legacy AVI unit is unchanged on GB20x. */
> =C2=A0=09.gsp.hdmi_infoframe_avi =3D gv100_sor_hdmi_infoframe_avi,
> =C2=A0=09.gsp.hdmi_infoframe_vsi =3D gb202_sor_hdmi_infoframe_vsi,

