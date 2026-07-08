Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526B2C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:17:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A721310E0AC;
	Wed,  8 Jul 2026 15:17:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jyohbZrh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZemzcvqA";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C94810E0AC
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 15:17:55 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668C5BoB2761963
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Jul 2026 15:17:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 B+HbO3q8cH7T+zYjIIdCRY6caTKPU+Ebh5i0go2meuU=; b=jyohbZrhJnWKjS2S
 jgxZv8TF6w/+aD1tw347JwBuBawqRoSyHQt4KBTGdAd6Ctw9bWxtSGBMiP5FwhRv
 +G3a6E4nMmpi0JOmkWKmYO6Xh0V+QhK0D98Z4rs0uVGwTxN7krtdmSxCJf9GIXeS
 3T3OWo/8rfGd7IGSRhycRPhmvG0MnEuc6zatXrBmgOoFe14WkfbAF/5SZuyZKO1/
 G9TFnm8eoYpIfo6ytwjjOCH5y31VqcH+irN8F7N0cUNI+0b3P80xsZZJpGauXKXI
 RbU1ymK68OZ4X8TbQx9dOYHYi0VPKKvlB7vX1tTdIL38OXQ2m4O50K8wR746yurM
 L7jRiQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95e5w45u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 15:17:54 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3811279d51aso1541400a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 08:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783523874; x=1784128674;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=B+HbO3q8cH7T+zYjIIdCRY6caTKPU+Ebh5i0go2meuU=;
 b=ZemzcvqA0W+p9NlhQhTtvYvx3mg0yENO/y4RPU8Ost8li0fj0vqnJSmXLZwRsU3T8M
 QdC7xmRcW7xIal7bd/pahaRzZgrJKCDrbHLupbgvF78UxuGsUdiPL2y1tM5Mbva7AI5w
 a3lJFdVFgBmU/CuGBRrkBhvQPJ4QmHr2xdBL7XRM2wUODcvafVmwkRQQJ9KhcuVqycqu
 uXg1DNvDdNlSWeQYq9bcb5HAtqvEfu75Ikhhzx9Dgg0hqFEfyjTP9bWyr3k2El/Mgndm
 8CJ94vDLlBdtq0Fjp8ZSkyEcZgVVr1c+8qBJd5pSckvUBMf310mPorypCm/vSXO+q1uI
 wpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783523874; x=1784128674;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B+HbO3q8cH7T+zYjIIdCRY6caTKPU+Ebh5i0go2meuU=;
 b=l+SYmmzvueaO9ArLe4UxznXVR+Ga3s8BxS5za30KlyIKR7+FfhAmlq5hoTkDwG5P2+
 C0dA5s58PIaa3FOcOu6r3X1DH1A9Evb4bKB/D93LDJUrBNDolwTcUF5UhyYCbrj5xu+Z
 2VmiSdr4Uys0jFHVRvlMb2jKTEUQ7gjomLi4Jo+rRJgTBOQW2lchQBS1E0Aj3jVXEXev
 Jyrsi/ErT7dchCcmbln9ogoPuwKkC4Af/GvreNTWpZnZJeb3YlAnct/IUgLbhONnmJ5O
 kRmMpxzncr/FJs9AyXXEDpa995L5NclVt08k2SkxDFMra+g/r3UnMjorEHS705AXUa24
 ZWsA==
X-Gm-Message-State: AOJu0Ywp1nhpl1HBpdg64NsOL6MKGmnQd9CTq/C2g17iiEViR3rQmPoq
 CwDcAF9A7G9AtT6U905zPjkaPSrq3BB//xnEzZeTQ4cRJRbrUdRCgRnRuFNdpWCsve34FLhBjzt
 70UWCWQ36Ch2gS3Lrxyb5YukQLA4wVKkqRk5/blOZi+h7ttXy0iM8GDAQiEeChgTdJ0ovidM=
X-Gm-Gg: AfdE7clsQHh1+NCFdOvJ8/LtJDRyfYwVdG0iDnaUlxGuyiBgCnVC3JXFjBnfKf9/FK6
 e432xVJoOLm0gt4drbpaQjyMR7y2OfxonnySLSaDyeoOBrT5BfqaXuIMa6xn/V9YSDpyqoXoiZx
 xo9UWQ1VYKIRzpOVkLSWfNJr9nALM5fOH0sF5WgmRC+NgP+7I9DEd2661X74V9R+PrLm5NAS5xU
 CG/eg/IhJRISfgBRiwESCCvSVz9m15cPIbUDpjEW65COZWKygrIi2wrpVtFiF3NDwVyj5fmJfTO
 bLp/lYf6xKeuFjNUWm88XdDIUWyJNauq43vKP9gDBoNJdT+zC/Jn4RdY98Ge+jnOymz31/jlEyz
 N7S9JlBF68xfG8jw=
X-Received: by 2002:a17:90b:2fc6:b0:381:20b:a9ee with SMTP id
 98e67ed59e1d1-38940631b27mr3071846a91.14.1783523873592; 
 Wed, 08 Jul 2026 08:17:53 -0700 (PDT)
X-Received: by 2002:a17:90b:2fc6:b0:381:20b:a9ee with SMTP id
 98e67ed59e1d1-38940631b27mr3071804a91.14.1783523873102; 
 Wed, 08 Jul 2026 08:17:53 -0700 (PDT)
Received: from localhost ([151.243.38.149]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-387d13fd7bfsm3005125a91.6.2026.07.08.08.17.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 08:17:52 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 23:17:37 +0800
Message-Id: <DJTAFX7D6MMM.N6Y4NZOI1GF8@oss.qualcomm.com>
Cc: <dri-devel@lists.freedesktop.org>, <Frank.Li@kernel.org>,
 <imx@lists.linux.dev>
Subject: Re: [PATCH 8/9] drm/tve200: replace struct drm_simple_display_pipe
 with regular atomic helpers
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: <sashiko-reviews@lists.linux.dev>, "Ze Huang" <ze.huang@oss.qualcomm.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com>
 <20260705-drm-simple-kms-removal-v1-8-b4e1ca053623@oss.qualcomm.com>
 <20260704184615.466FA1F000E9@smtp.kernel.org>
In-Reply-To: <20260704184615.466FA1F000E9@smtp.kernel.org>
X-Proofpoint-GUID: ca9nS5G0Q2EzySno8ZA39X-VY5m1f-xe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE1MCBTYWx0ZWRfXw3j+GtbZf2Lm
 OFZpV9wNuWLRKsfGFSCUm40oFrxzA5loclAh8vkwvTdlIlZGE4ke3mPndAHIsi4YEaB0oVbE9cn
 B/ikcgpml0/mjSfPUTSj6SZxFMmab+I=
X-Authority-Analysis: v=2.4 cv=CNoamxrD c=1 sm=1 tr=0 ts=6a4e6a22 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=cNux22OjBTKCC6TmznXXXA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=egV5sixoXBkJpWEyV9UA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: ca9nS5G0Q2EzySno8ZA39X-VY5m1f-xe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE1MCBTYWx0ZWRfXyMLhJzS1dxJp
 LF/JmTU18jL49uUzxCAZhXKZW0gK1FLey77eIJZU58/pd5/s9pvIl/PJVXqlkJR5IviALlf9et0
 13vNcflJWcwq50seXFqZTlazqvi5YbG6CBxHD8QLUYe9T5vaQh1rj4xyb+m1TJZsYf/4YMlGcJp
 Bq/7Ey0nkpTi2o8CDEC9w5ORlRlWVmWko+4ofJZB096GeGeQBNcxrEEpQFqBoqMuUxAmo2U4osq
 0DTx5tFFVeHK7z6Uyl0Qtt/ufzDegAl6PPS+c4whudlqpDOFfW8UYp01TJv9nLUKuJY7/M5CCVM
 VevVS72GhKArtdRvsuHP77OreHCwrmu3QkHKmfJpiBy77Ey/gxc3fRKmpEBSOWAzk7QQoJtjjdS
 ONkQ4PO2qmGAezBSF+UgdkhP0xBBScM+aur3+1zaOBPL0+bos+13J4jFmtVfIJFs6KXA2i7L/J7
 Hx6bogbEE56QOuyRsmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080150
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

On Sun Jul 5, 2026 at 2:46 AM CST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
>
> New issues:
> - [High] Vblank event is leaked on CRTC disable and may be delivered prem=
aturely on CRTC enable.
> - [Medium] Calling `drm_connector_attach_encoder()` on an uninitialized c=
onnector.
>
> Pre-existing issues:
> - [High] Calling `usleep_range()` from a CRTC `atomic_enable` callback.
> - [High] Direct, lockless access to global state pointers `plane->state` =
and `crtc->state` in atomic commit callbacks.
> --
>
> Note: The format of this review has been altered to a free-form summary d=
ue
> to mailing list quoting restrictions.
>
> Commit: 2c5e6508a64461d7a207075c4328681142076aef
> Author: Ze Huang <ze.huang@oss.qualcomm.com>
> Subject: drm/tve200: replace struct drm_simple_display_pipe with regular =
atomic helpers
> Summary: This commit converts the TVE200 driver to use explicit plane, CR=
TC,
> and encoder objects instead of the simple display pipe helpers, while kee=
ping
> generic plane-state validation and GEM framebuffer preparation.
>
> [Severity: High]
> In drivers/gpu/drm/tve200/tve200_display.c,
> tve200_plane_helper_atomic_update() checks if the CRTC is NULL and return=
s
> early. Does this cause the pending vblank event to be leaked during a CRT=
C
> disable, since the plane is also disabled (making crtc NULL) and the even=
t
> is never consumed?

Will fix it

>
> Additionally, since commit_planes() executes before commit_modeset_enable=
s(),
> is the event processed and delivered prematurely on CRTC enable? Could th=
e
> event consumption be moved to CRTC callbacks like atomic_enable,
> atomic_disable, or atomic_flush instead of handling it in the plane callb=
ack?
>

Yes, will move them to atomic_flush

> [Severity: Medium]
> In drivers/gpu/drm/tve200/tve200_drv.c, tve200_modeset_init() gets the
> connector using drm_panel_bridge_connector() and immediately passes it to
> drm_connector_attach_encoder(). Since drm_bridge_attach() has not run yet=
,
> is this modifying an uninitialized DRM object structure?
>
> Would it be better to rely on panel_bridge_attach(), which already
> automatically handles attaching the connector to the encoder, making this
> manual call redundant?

Will move drm_bridge_attach() before drm_panel_bridge_connector() and drop
drm_connector_attach_encoder() like:

    priv->panel =3D panel;
    priv->bridge =3D bridge;

    ret =3D drm_bridge_attach(&priv->encoder, bridge, NULL, 0);
    if (ret) {
    dev_err(dev->dev, "failed to attach bridge\n");
    goto out_bridge;
    }

    priv->connector =3D drm_panel_bridge_connector(bridge);
    if (!priv->connector) {
    ret =3D -ENODEV;
    goto out_bridge;
    }

>
> [Severity: High]
> This isn't a bug introduced by this patch, but in
> drivers/gpu/drm/tve200/tve200_display.c, tve200_crtc_helper_atomic_enable=
()
> contains a hardware polling loop that calls usleep_range(30000, 50000).
> Since CRTC atomic enable callbacks run in atomic context during non-block=
ing
> commits where sleeping is strictly forbidden, can this cause kernel warni=
ngs
> or deadlocks? Should this be replaced with non-sleeping delay functions l=
ike
> udelay or ndelay?
>
> [Severity: High]
> This is a pre-existing issue, but it appears to be expanded here. In
> drivers/gpu/drm/tve200/tve200_display.c, tve200_plane_helper_atomic_updat=
e()
> and tve200_crtc_helper_atomic_enable() directly access the global state
> pointers plane->state and priv->plane.state.
>
> In non-blocking commits, these global pointers can be swapped if userspac=
e
> submits a concurrent commit. Does this create a TOCTOU race where a
> concurrent commit setting the framebuffer to NULL could lead to a NULL
> pointer dereference when accessing fb->format->format? Should this code u=
se
> the proper drm_atomic_get_new_plane_state() (or equivalent) accessors on =
the
> passed state object instead?

