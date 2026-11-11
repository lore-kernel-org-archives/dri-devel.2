Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51352606A8A9
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 19:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.claussen10@web.de header.a=rsa-sha256 header.s=s29768273 header.b=HboT1hEa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFBAE10E096;
	Wed, 11 Nov 2026 19:13:17 +0000 (UTC)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 581BF10E096
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 19:13:10 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1794424388; mf=PGphbi5jbGF1c3NlbjEwQHdlYi5kZT4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=web.de;
 s=s29768273:rsa-sha256:lKhgWLVldqPWJI+qskYLulAOIQoX
 kJsKcEMLxYvpPx0yXCGWug9u67YuY4kuvTl8V4X6JchPlcKP0cVrnzUfgaPAf4ebQQTmm8yDi2G
 ehMnaBSPMqmosDywkq+dgpjUFzPAF5GtyUMqWEEQ8R6M7wr8ytv54ucs1YmdDrZpXdXhikQfEWH
 VYQBbN6LPimNlwHsACzbH6/Q8kteg7NIjJllw7Fv20svj+mSbGAPHI0Zl1pqt6ChrCln44ohUuW
 y2GdWWK3pqadIEiKNLIEcxTcol1WiKoezvrfsw5YYRQvL31kTa7+cOBR8BB8xaOisIuIvpJb6nT
 80gI+BtF8WqSGQ==;
Message-Instance: m=1; h=sha256: 2B6F8v4B17sFO1hThb1Lj97K5524iO7PxR5OYBAbIzQ=:
 gfnH44qngO01SocZOoN90D7F8dJA3waGnbCpEYeOoiQ=, sha512:
 d6Aq67KXwUrBis1VTRfCZt4GvZy87pf47cxGBaJWpnHHVcCeb5IzIrKjtJOf+8nvUzZdaiTWiQx+OOqWwoC2tw==:
 MKzT83NUMmsSs5xq8Aj7YIKTsFGIA7aseqTv07f9gFGhu8TsOqGZYP2y2zyTFvgYImvpf7eTNZjYWli6/QgzZg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1794424363; x=1795029163; i=jan.claussen10@web.de;
 bh=fNu9ppPJc/9axGdpVkNeonSwSCx0e4/tpsf+kAethLk=;
 h=X-UI-Sender-Class:Content-Type:Content-Transfer-Encoding:From:
 Mime-Version:Subject:Date:Message-Id:References:Cc:In-Reply-To:To:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=HboT1hEaeWnv+EWYkBaoRHpvzwcDZ8qnk9cFW7uhBrelEdQG8TxnZRVsyyvvP9et
 DsBwaDvzRxkUPX36gMOPt5NRKd7UunKWWY8m59HUM6E0Cq1X9hKhwzk2ZvG3xRo31
 7K92eyyIikbahJGre3m6APz5SIQ6bcaYYEz943k/9mGvW9zxy1dOpyJOmY3Wk6IAa
 qmUQ1D/mQdylPmWskM0SD725OmK1Q6OYqr6y/gZCo6Lyx9CgSekgMKqeyyGQop3R+
 yZ3ss+XUim4anAQIZsQp3H+uRtw/i8h+vAiRS4xA2WjSpBmjzbpQmV9o0MS3yz9Em
 pVzAm1wUfySu6obtng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdwJY-1wrKV30Acg-00ovC4; Wed, 11
 Nov 2026 20:12:43 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: =?utf-8?Q?Jan_Clau=C3=9Fen?= <jan.claussen10@web.de>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 6/7] drm/rockchip: dw_hdmi_qp: Set the VOP2 color space
 from the connector
Date: Wed, 11 Nov 2026 20:12:29 +0100
Message-Id: <0347891E-6A6B-421A-B373-8A06DA394D9E@web.de>
References: <7f4c2132-bb73-4698-ab68-902fada398b6@collabora.com>
Cc: Chaoyi Chen <chaoyi.chen@rock-chips.com>, Sandy Huang <hjc@rock-chips.com>,
 =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <7f4c2132-bb73-4698-ab68-902fada398b6@collabora.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
X-Mailer: iPhone Mail (22H124)
X-Provags-ID: V03:K1:wqDWHQ88l+uOsmu6WEMhKlf02JZUU3HV0X1u/z6b7HyST9df32M
 Uchvif+McgVVT+lhs87Yj+ax6HaOwJ74pEz9mNO1wwSvRh/DHs9GIhdG8OvXjHd/lCJQjxq
 fz2JxHg9NRjhFCpQcki/gxIn0T3fMeNy452NtoCbNxnEQ1yrTTo+d+w7DdDe2Kswb9wI9/Z
 Hm0C7I8oBJB50NB0yy8VQ==
UI-OutboundReport: notjunk:1;M01:P0:Fvm9BeuuvmU=;0dLRvtS/irQXCp/RoIba9tp8U+D
 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
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_DEVICE_2
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Cristian and Chaoyi,

thank you and noted. Going to look into this soon!

Any other concerns about my approach? Main concern sounds like it=E2=80=99s n=
ot the only one.

Cheers,
Jan


> Am 11.11.2026 um 10:41 schrieb Cristian Ciocaltea <cristian.ciocaltea@coll=
abora.com>:
>=20
> =EF=BB=BFHi Chaoyi,
>=20
>> On 11/11/26 8:19 AM, Chaoyi Chen wrote:
>> Hi Cristian and Jan,
>>=20
>>> On 11/11/2026 3:05 AM, Cristian Ciocaltea wrote:
>>> Hi Jan,
>>>=20
>>> On 10/18/26 5:31 PM, Jan Clau=C3=9Fen wrote:
>>>> VOP2 converts RGB to YCbCr using the matrix selected by the CRTC
>>>> state's color_space, but the HDMI encoder never sets it, so VOP2
>>>> always converts with BT.709. Once the colorspace property can
>>>> signal BT.2020 colorimetry to the sink, a YCbCr output would be
>>>> encoded with BT.709 and decoded with BT.2020.
>>>>=20
>>>> Derive color_space from the connector colorspace before the early
>>>> return, so that a colorspace change alone is applied.
>>>>=20
>>>> Signed-off-by: Jan Clau=C3=9Fen <jan.claussen10@web.de>
>>>> ---
>>>> drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 16 ++++++++++++++++
>>>> 1 file changed, 16 insertions(+)
>>>>=20
>>>> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/g=
pu/drm/rockchip/dw_hdmi_qp-rockchip.c
>>>> index 9c4cf68d79d5..10c5b6d6406e 100644
>>>> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
>>>> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
>>>> @@ -17,6 +17,7 @@
>>>> #include <linux/phy/phy.h>
>>>> #include <linux/phy/phy-hdmi.h>
>>>> #include <linux/regmap.h>
>>>> +#include <linux/videodev2.h>
>>>> #include <linux/workqueue.h>
>>>>=20
>>>> #include <drm/bridge/dw_hdmi_qp.h>
>>>> @@ -187,6 +188,19 @@ static int dw_hdmi_qp_rockchip_get_vop_format(stru=
ct drm_encoder *encoder,
>>>>    return bstate->output_bus_cfg.format;
>>>> }
>>>>=20
>>>> +static u32
>>>> +dw_hdmi_qp_rockchip_color_space(const struct drm_connector_state *conn=
_state)
>>>> +{
>>>> +    switch (conn_state->colorspace) {
>>>> +    case DRM_MODE_COLORIMETRY_BT2020_RGB:
>>>> +    case DRM_MODE_COLORIMETRY_BT2020_YCC:
>>>> +    case DRM_MODE_COLORIMETRY_BT2020_CYCC:
>>>> +        return V4L2_COLORSPACE_BT2020;
>>>> +    default:
>>>> +        return V4L2_COLORSPACE_DEFAULT;
>>>> +    }
>>>> +}
>>>=20
>>> My main concern is introducing V4L2_COLORSPACE_* logic into a DRM bridge=
 driver,
>>> which should rather rely on enum drm_colorspace / DRM_MODE_COLORIMETRY_*=
.
>>> Translating the DRM colorimetry into V4L2 values only for VOP2 to map th=
em back
>>> to a CSC matrix doesn't seem fully justified.
>>>=20
>>> The root problem is rather on the VOP2 side: the color_space field in st=
ruct
>>> rockchip_crtc_state and its V4L2-based handling in the CSC selection loo=
k like
>>> leftovers inherited from the vendor kernel, and I think this is a good t=
ime to
>>> clean that up instead of building on it.
>>>=20
>>=20
>> Yep. And if you look at the latest vendor kernel code, we have also
>> removed the V4L2_COLORSPACE_* related content and switched to DRM.
>=20
> Thanks for the heads-up; I haven't checked the recent vendor kernel change=
s.
>=20
> Regards,
> Cristian
>=20

