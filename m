Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6668C606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=npnm.eu header.i=@npnm.eu header.a=rsa-sha256 header.s=ovhmo-selector-1 header.b=lbTKHwFE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 727C910E4C8;
	Fri, 27 Nov 2026 08:29:09 +0000 (UTC)
Received: from 6.mo2.mail-out.ovh.net (6.mo2.mail-out.ovh.net [178.33.109.252])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4FAA10E9AE
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:13:48 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo2.mail-out.ovh.net (Postfix) with ESMTPS id 4jZz6y3XYKz42f5;
 Thu, 26 Nov 2026 14:13:46 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <dakr@kernel.org>; Thu, 26 Nov 2026 14:13:46 +0000 (UTC)
Received: from mta3.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.0.169])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4jZz6y1nR6z1xxH;
 Thu, 26 Nov 2026 14:13:46 +0000 (UTC)
Received: from npnm.eu (unknown [10.1.6.2])
 (Authenticated sender: laniel_francis@npnm.eu)
 by mta3.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 0A214942153; 
 Thu, 26 Nov 2026 14:13:44 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-112S006542bf720-37e3-4677-9f40-7e48ff031ce1,
 230BAD52BFC520DA66055B44D06E91CCCAB19385) smtp.auth=laniel_francis@npnm.eu
X-OVh-ClientIp: 159.26.112.43
From: Francis Laniel <laniel_francis@npnm.eu>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH] drm/nouveau/devinit/gf100-: fix double vbios init checks
Date: Thu, 26 Nov 2026 16:13:43 +0200
Message-ID: <5119322.GXAFRqVoOG@pmachine>
In-Reply-To: <20261123-nouveau-fix-disp-v1-1-ebdc525287ce@redhat.com>
References: <20261123-nouveau-fix-disp-v1-1-ebdc525287ce@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
x-ovh-tracer-id: 4510917978956178936
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF0IONlquxZNWUhUvGZyMCQXwLelxUagklbWqSogw585TOg8zBW1CXrB92mV4jjXV3xgsW9KNCjNOU2FP4N2sOsLHXD2JkUaStcOk0tHwOBS1rDF8lJXebPmbJHI5BQHECQxVUqh8A1xD/LbSiVu0myBy2GK/chXDQUDhckvyOPbUk56Gnybx+ycusaZrrBCiaIndF4UCka36c8sE67FTXvTKQiexPtYoxEqJKxz842l394MvKAYXw3L1ajM9osvTqYMXRqP39heWExXTZvm2OucXnxFDdV4DfbByzTqzu2x9+pDYVDfK1NsEdqd0DPhURYd34+bl9x4U0biz9H2u4ahDWdGaOWawiI+IU6KnDDFUF+esdL/XkjxfANAxW1WzxNiUt1yJFksOl1p8SKdCAMcXNWTVQgBRK1HazAHOCwVn/dsnvNSrbTjHxTsJvptUzRPYNJ/RLVKNvWMNcQ2Lo979mjkNl5DakGfX05vjaBeGHcJE4l6qyC4+zByzLI/hlngq/XDyrkE/uGwm4Rd2DCf7sWSfYpI9rk7H88JiLCJBjAhdUg6Xj37axj3iSJ3nuTk1p3XfFJyWQa+mPB07DLABk/COxyZ97tuDYplEOMQW5qPIHuQoRPYIW5fXEE35oSL4r/OAGN/+aWK3mYmqPbzYPQh5JODJ14Z7xOt5KNRw
DKIM-Signature: a=rsa-sha256; bh=t19ExeCYrk4svaMovrOfWcyhStdg0gO19dQd849gvH8=; 
 c=relaxed/relaxed; d=npnm.eu; h=From; s=ovhmo-selector-1;
 t=1795702426; v=1;
 b=lbTKHwFEwZUcmaVMfjG8WspeQFR97ebVOsWV22ndDSxiTmfmlIaohr3Hz53ZLG6IKGvEGpX5
 p9JrQULNOC80AfMLMhVSnic4g8ugQHJG9GlyJt1sB/+mmf7kIsaKPj2ZWMrthCxJZ2w0FQRL+wG
 uD44kMy9fflDA9nBV8L53BrMajwaNgTX0n36Cyz2hCbOkRAFQhDCL8MSYKc3zj2Qred4B4SiA8N
 Ba5sisDd4xwPgZ08/+o26ljee/WBmSuxEsnPrMHBdLZ53WRpk9HuHA8xjxETWb6ne8v9u4HH6Ak
 r9smHq2/wrZudq8izON0yXuziNE1h2P/Gef6K1jxpGjAw==
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Le lundi 23 novembre 2026, 02:25:26 heure normale d=E2=80=99Europe de l=E2=
=80=99Ouest Dave Airlie a =C3=A9crit :
> The initial fix from 2017 wasn't updated for modern nouveau devinit
> disable paths.
>=20
> Fix that and just check if display exists instead.
>=20
> Fixes: 2139cb633d48 ("drm/nouveau/devinit/gf100-: try to avoid double-run=
ning vbios scripts")
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c b/driver=
s/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
> index 186e09ea0cb1..b256404c2454 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
> @@ -107,12 +107,12 @@ gf100_devinit_preinit(struct nvkm_devinit *base)
>  	 * VBIOS multiple times may have detrimental effects.
>  	 */
>  	if (base->post) {
> -		u64 disable =3D nvkm_devinit_disable(base);
> +		nvkm_devinit_disable(base);
>  		/* magic to detect whether or not x86 vbios code has
>  		 * executed the devinit scripts to initialise the
>  		 * board. only works if there's a display engine.
>  		 */
> -		if (!(disable & (1ULL << NVKM_ENGINE_DISP))) {
> +		if (device->disp) {
>  			if (nvkm_rdvgac(device, 0, 0x00) ||
>  			    nvkm_rdvgac(device, 0, 0x1a)) {
>  				base->post =3D false;
>=20
> ---
> base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
> change-id: 20261123-nouveau-fix-disp-62f59fd96fee
>=20
> Best regards,
>=20

Thank you for the patch! I tested it, and I can now boot my laptop with it:
[    1.404564] nouveau: loading out-of-tree module taints kernel.
[    1.404624] nouveau: module verification failed: signature and/or requir=
ed key missing - tainting kernel
[    1.739550] nouveau: detected PR support, will not use DSM
[    1.739571] nouveau 0000:2d:00.0: enabling device (0006 -> 0007)
[    1.739648] nouveau 0000:2d:00.0: NVIDIA GP108 (138000a1)
[    1.776320] nouveau 0000:2d:00.0: bios: version 86.08.3e.00.26
[    1.776582] nouveau 0000:2d:00.0: pmu: firmware unavailable
[    1.860292] nouveau 0000:2d:00.0: fb: 2048 MiB GDDR5
[    1.897865] nouveau 0000:2d:00.0: drm: VRAM: 2048 MiB
[    1.897868] nouveau 0000:2d:00.0: drm: GART: 536870912 MiB
[    1.897869] nouveau 0000:2d:00.0: drm: BIT table 'A' not found
[    1.897871] nouveau 0000:2d:00.0: drm: BIT table 'L' not found
[    1.897871] nouveau 0000:2d:00.0: drm: Pointer to TMDS table not found
[    1.902700] nouveau 0000:2d:00.0: drm: MM: using COPY for buffer copies
[    1.902820] [drm] Initialized nouveau 1.4.0 for 0000:2d:00.0 on minor 0
[    1.902908] nouveau 0000:2d:00.0: [drm] No compatible format found
[    1.902910] nouveau 0000:2d:00.0: [drm] Cannot find any crtc or sizes

Tested-by: Francis Laniel <laniel_francis@npnm.eu>

As 2139cb633d48 ("drm/nouveau/devinit/gf100-: try to avoid double-running v=
bios scripts")
is part of stable kernel, at least 6.12.118, I am wondering if this should =
be also posted to stable?
Particularly as some other debian users are hit by this:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D+1155040
What do you think?

Best regards,





