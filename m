Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57160606A325
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=xywovkiA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBB7D10EA1F;
	Sun,  1 Nov 2026 12:02:00 +0000 (UTC)
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com
 [111.22.67.151])
 by gabe.freedesktop.org (Postfix) with ESMTP id B167B11275D
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 11:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmss.chinamobile.com; s=default; l=0;
 h=from:subject:message-id:to:cc:mime-version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=xywovkiA3VfpN9ZaHkY6ooDMm+/0HsaXuvTFrwbJVQ9XF9cBRb/mfpiDKSN2evauRtzIRF5DYBBYf
 oDUUGD4WMguRwKgVZ00OsdQacR0N4LYlVeHxtYWh5RWAtB0Nfo3Iw4fXjK2Mh+2Ch1oLA3/sOQubWe
 5VOdzecF+qScWmCs=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66ae47c5dab3-41f4a;
 Fri, 30 Oct 2026 19:15:43 +0800 (CST)
X-RM-TRANSID: 2ee66ae47c5dab3-41f4a
X-RM-SPAM-FLAG: 00000000
Received: from laixiangwu@cmss.chinamobile.com ( [10.55.1.71] )
 by ajax-webmail-syy-appsvr08-11008 (Richmail) with HTTP;
 Fri, 30 Oct 2026 19:15:43 +0800 (CST)
Date: Fri, 30 Oct 2026 19:15:43 +0800 (CST)
From: =?utf-8?B?6LWW6aaZ5q2m?= <laixiangwu@cmss.chinamobile.com>
To: LaurentiuPalcu <laurentiu.palcu@oss.nxp.com>
Cc: MaartenLankhorst <maarten.lankhorst@linux.intel.com>, 
 MaximeRipard <mripard@kernel.org>, 
 ThomasZimmermann <tzimmermann@suse.de>, 
 DavidAirlie <airlied@gmail.com>, SimonaVetter <simona@ffwll.ch>, 
 FrankLi <Frank.Li@nxp.com>, SaschaHauer <s.hauer@pengutronix.de>, 
 LucasStach <l.stach@pengutronix.de>, 
 PengutronixKernelTeam <kernel@pengutronix.de>, 
 FabioEstevam <festevam@gmail.com>, 
 dri-devel <dri-devel@lists.freedesktop.org>, imx <imx@lists.linux.dev>, 
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <2b006ae46df006f-0002e.Richmail.00002062822211147236@cmss.chinamobile.com>
References: <20261030083342.1531-1-laixiangwu@cmss.chinamobile.com>,
 <auRgElrEh0YlUaKc@vm>
Subject: Re:Re: [PATCH] drm/imx/dcss: Fix clock leak on blkctl init failure
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="----=_Part_774147_2058071162.1793358943045"
X-Priority: 3
X-RM-TRANSID: 2b006ae46df006f-0002e
X-PARTNER-PROJECT-ID: 0
X-RM-OA-ENC-TYPE: 0
X-RM-FontColor: 0
X-CLIENT-INFO: X-TIMING=0&X-MASSSENT=0&X-SENSITIVE=0
X-Mailer: Richmail_Webapp(V2.5.01)
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_FACE_BAD,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

------=_Part_774147_2058071162.1793358943045
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: quoted-printable



Hi Laurentiu,






Thank you for the review!






I have renamed the error labels as you suggested and sent a v2, which


threads below this mail. Please take a look.






Best regards,






laixiangwu



----=E9=82=AE=E4=BB=B6=E5=8E=9F=E6=96=87----
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9ALaurentiu Palcu=20
=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Alaixiangwu=20
=E6=8A=84=E3=80=80=E9=80=81: Maarten Lankhorst ,Maxime Ripard ,Thomas Zimme=
rmann ,David Airlie ,Simona Vetter ,Frank Li ,Sascha Hauer ,Lucas Stach ,Pe=
ngutronix Kernel Team ,Fabio Estevam ,dri-devel ,imx ,linux-arm-kernel ,lin=
ux-kernel=20
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2026-10-30 17:26:22
=E4=B8=BB=E9=A2=98=EF=BC=9ARe: [PATCH] drm/imx/dcss: Fix clock leak on blkc=
tl init failure

Hi,

Thank you for the fix.

On Fri, Oct 30, 2026 at 04:33:42PM +0800, laixiangwu wrote:
> dcss_submodules_init() enables the DCSS clocks before initializing the
> submodules, but if the first submodule (blkctl) fails to initialize the
> function returns directly, without disabling the clocks again. All the
> later error paths already jump to ctxld_err, which calls
> dcss_clocks_disable().
>=20
> Since the clocks are only devm-managed for their reference (devm_clk_get)=
,
> a blkctl init failure leaves all five DCSS clocks prepared and enabled.
>=20
> Jump to ctxld_err so the clocks are disabled like on the other error
> paths.
>=20
> Fixes: 9021c317b770 ("drm/imx: Add initial support for DCSS on iMX8MQ")
> Signed-off-by: laixiangwu=20
> ---
> drivers/gpu/drm/imx/dcss/dcss-dev.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.c b/drivers/gpu/drm/imx/dc=
ss/dcss-dev.c
> index 7fd0c4c14..551786060 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-dev.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-dev.c
> @@ -70,7 +70,7 @@ static int dcss_submodules_init(struct dcss_dev *dcss)
>=20
> ret =3D dcss_blkctl_init(dcss, base_addr + devtype->blkctl_ofs)
> if (ret)
> - return ret
> + goto ctxld_err

With this change, now the label names I chose when I first developed this
driver don't feel right. Could you please send a v2 and rename those labels
below as well?

I'm thinking:
ctxld_err -> err_clocks
dtg_err -> err_ctxld
ss_err -> err_dtg
dpr_err -> err_ss
scaler_err -> err_dpr

Update those 'goto' lines accordingly.

--=20
Thanks,
Laurentiu

Subject=EF=BC=9ARe: [PATCH] drm/imx/dcss: Fix clock leak on blkctl init fai=
lure

Hi,

Thank you for the fix.

On Fri, Oct 30, 2026 at 04:33:42PM +0800, laixiangwu wrote:
> dcss_submodules_init() enables the DCSS clocks before initializing the
> submodules, but if the first submodule (blkctl) fails to initialize the
> function returns directly, without disabling the clocks again. All the
> later error paths already jump to ctxld_err, which calls
> dcss_clocks_disable().
>=20
> Since the clocks are only devm-managed for their reference (devm_clk_get)=
,
> a blkctl init failure leaves all five DCSS clocks prepared and enabled.
>=20
> Jump to ctxld_err so the clocks are disabled like on the other error
> paths.
>=20
> Fixes: 9021c317b770 ("drm/imx: Add initial support for DCSS on iMX8MQ")
> Signed-off-by: laixiangwu=20
> ---
> drivers/gpu/drm/imx/dcss/dcss-dev.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.c b/drivers/gpu/drm/imx/dc=
ss/dcss-dev.c
> index 7fd0c4c14..551786060 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-dev.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-dev.c
> @@ -70,7 +70,7 @@ static int dcss_submodules_init(struct dcss_dev *dcss)
>=20
> ret =3D dcss_blkctl_init(dcss, base_addr + devtype->blkctl_ofs)
> if (ret)
> - return ret
> + goto ctxld_err

With this change, now the label names I chose when I first developed this
driver don't feel right. Could you please send a v2 and rename those labels
below as well?

I'm thinking:
ctxld_err -> err_clocks
dtg_err -> err_ctxld
ss_err -> err_dtg
dpr_err -> err_ss
scaler_err -> err_dpr

Update those 'goto' lines accordingly.

--=20
Thanks,
Laurentiu







=20

------=_Part_774147_2058071162.1793358943045
Content-Type: text/html;charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div id=3D"sign"><p style=3D"margin: 0px 0px 5px; padding: 0px; box-sizing:=
 border-box; -webkit-tap-highlight-color: transparent; background-color: rg=
b(255, 255, 255);"><font color=3D"#656d76" face=3D"-apple-system, BlinkMacS=
ystemFont, PingFang SC, Microsoft YaHei, Noto Sans SC, Segoe UI, Roboto, sa=
ns-serif"><span style=3D"font-size: 14px;">Hi Laurentiu,</span></font></p><=
p style=3D"margin: 0px 0px 5px; padding: 0px; box-sizing: border-box; -webk=
it-tap-highlight-color: transparent; background-color: rgb(255, 255, 255);"=
><font color=3D"#656d76" face=3D"-apple-system, BlinkMacSystemFont, PingFan=
g SC, Microsoft YaHei, Noto Sans SC, Segoe UI, Roboto, sans-serif"><span st=
yle=3D"font-size: 14px;"><br></span></font></p><p style=3D"margin: 0px 0px =
5px; padding: 0px; box-sizing: border-box; -webkit-tap-highlight-color: tra=
nsparent; background-color: rgb(255, 255, 255);"><font color=3D"#656d76" fa=
ce=3D"-apple-system, BlinkMacSystemFont, PingFang SC, Microsoft YaHei, Noto=
 Sans SC, Segoe UI, Roboto, sans-serif"><span style=3D"font-size: 14px;">Th=
ank you for the review!</span></font></p><p style=3D"margin: 0px 0px 5px; p=
adding: 0px; box-sizing: border-box; -webkit-tap-highlight-color: transpare=
nt; background-color: rgb(255, 255, 255);"><font color=3D"#656d76" face=3D"=
-apple-system, BlinkMacSystemFont, PingFang SC, Microsoft YaHei, Noto Sans =
SC, Segoe UI, Roboto, sans-serif"><span style=3D"font-size: 14px;"><br></sp=
an></font></p><p style=3D"margin: 0px 0px 5px; padding: 0px; box-sizing: bo=
rder-box; -webkit-tap-highlight-color: transparent; background-color: rgb(2=
55, 255, 255);"><font color=3D"#656d76" face=3D"-apple-system, BlinkMacSyst=
emFont, PingFang SC, Microsoft YaHei, Noto Sans SC, Segoe UI, Roboto, sans-=
serif"><span style=3D"font-size: 14px;">I have renamed the error labels as =
you suggested and sent a v2, which</span></font></p><p style=3D"margin: 0px=
 0px 5px; padding: 0px; box-sizing: border-box; -webkit-tap-highlight-color=
: transparent; background-color: rgb(255, 255, 255);"><font color=3D"#656d7=
6" face=3D"-apple-system, BlinkMacSystemFont, PingFang SC, Microsoft YaHei,=
 Noto Sans SC, Segoe UI, Roboto, sans-serif"><span style=3D"font-size: 14px=
;">threads below this mail. Please take a look.</span></font></p><p style=
=3D"margin: 0px 0px 5px; padding: 0px; box-sizing: border-box; -webkit-tap-=
highlight-color: transparent; background-color: rgb(255, 255, 255);"><font =
color=3D"#656d76" face=3D"-apple-system, BlinkMacSystemFont, PingFang SC, M=
icrosoft YaHei, Noto Sans SC, Segoe UI, Roboto, sans-serif"><span style=3D"=
font-size: 14px;"><br></span></font></p><p style=3D"margin: 0px 0px 5px; pa=
dding: 0px; box-sizing: border-box; -webkit-tap-highlight-color: transparen=
t; background-color: rgb(255, 255, 255);"><font color=3D"#656d76" face=3D"-=
apple-system, BlinkMacSystemFont, PingFang SC, Microsoft YaHei, Noto Sans S=
C, Segoe UI, Roboto, sans-serif"><span style=3D"font-size: 14px;">Best rega=
rds,</span></font></p><p style=3D"margin: 0px 0px 5px; padding: 0px; box-si=
zing: border-box; -webkit-tap-highlight-color: transparent; background-colo=
r: rgb(255, 255, 255);"><font color=3D"#656d76" face=3D"-apple-system, Blin=
kMacSystemFont, PingFang SC, Microsoft YaHei, Noto Sans SC, Segoe UI, Robot=
o, sans-serif"><span style=3D"font-size: 14px;"><br></span></font></p><p st=
yle=3D"margin: 0px 0px 5px; padding: 0px; box-sizing: border-box; -webkit-t=
ap-highlight-color: transparent; background-color: rgb(255, 255, 255);"><fo=
nt color=3D"#656d76" face=3D"-apple-system, BlinkMacSystemFont, PingFang SC=
, Microsoft YaHei, Noto Sans SC, Segoe UI, Roboto, sans-serif"><span style=
=3D"font-size: 14px;">laixiangwu</span></font></p></div><br>----=E9=82=AE=
=E4=BB=B6=E5=8E=9F=E6=96=87----
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9ALaurentiu Palcu  <laurentiu.palcu@oss.n=
xp.com>
=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Alaixiangwu  <laixiangwu@cmss.chinamobil=
e.com>
=E6=8A=84=E3=80=80=E9=80=81: Maarten Lankhorst  <maarten.lankhorst@linux.in=
tel.com>,Maxime Ripard  <mripard@kernel.org>,Thomas Zimmermann  <tzimmerman=
n@suse.de>,David Airlie  <airlied@gmail.com>,Simona Vetter  <simona@ffwll.c=
h>,Frank Li  <frank.li@nxp.com>,Sascha Hauer  <s.hauer@pengutronix.de>,Luca=
s Stach  <l.stach@pengutronix.de>,Pengutronix Kernel Team  <kernel@pengutro=
nix.de>,Fabio Estevam  <festevam@gmail.com>,dri-devel <dri-devel@lists.free=
desktop.org>,imx <imx@lists.linux.dev>,linux-arm-kernel <linux-arm-kernel@l=
ists.infradead.org>,linux-kernel <linux-kernel@vger.kernel.org>
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2026-10-30 17:26:22
=E4=B8=BB=E9=A2=98=EF=BC=9ARe: [PATCH] drm/imx/dcss: Fix clock leak on blkc=
tl init failure

Hi,

Thank you for the fix.

On Fri, Oct 30, 2026 at 04:33:42PM +0800, laixiangwu wrote:
&gt; dcss_submodules_init() enables the DCSS clocks before initializing the
&gt; submodules, but if the first submodule (blkctl) fails to initialize th=
e
&gt; function returns directly, without disabling the clocks again. All the
&gt; later error paths already jump to ctxld_err, which calls
&gt; dcss_clocks_disable().
&gt;=20
&gt; Since the clocks are only devm-managed for their reference (devm_clk_g=
et),
&gt; a blkctl init failure leaves all five DCSS clocks prepared and enabled=
.
&gt;=20
&gt; Jump to ctxld_err so the clocks are disabled like on the other error
&gt; paths.
&gt;=20
&gt; Fixes: 9021c317b770 ("drm/imx: Add initial support for DCSS on iMX8MQ"=
)
&gt; Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>
&gt; ---
&gt;  drivers/gpu/drm/imx/dcss/dcss-dev.c | 2 +-
&gt;  1 file changed, 1 insertion(+), 1 deletion(-)
&gt;=20
&gt; diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.c b/drivers/gpu/drm/imx=
/dcss/dcss-dev.c
&gt; index 7fd0c4c14..551786060 100644
&gt; --- a/drivers/gpu/drm/imx/dcss/dcss-dev.c
&gt; +++ b/drivers/gpu/drm/imx/dcss/dcss-dev.c
&gt; @@ -70,7 +70,7 @@ static int dcss_submodules_init(struct dcss_dev *dcs=
s)
&gt;=20
&gt;         ret =3D dcss_blkctl_init(dcss, base_addr + devtype-&gt;blkctl_=
ofs);
&gt;         if (ret)
&gt; -               return ret;
&gt; +               goto ctxld_err;

With this change, now the label names I chose when I first developed this
driver don't feel right. Could you please send a v2 and rename those labels
below as well?

I'm thinking:
ctxld_err -&gt; err_clocks
dtg_err -&gt; err_ctxld
ss_err -&gt; err_dtg
dpr_err -&gt; err_ss
scaler_err -&gt; err_dpr

Update those 'goto' lines accordingly.

--=20
Thanks,
Laurentiu

Subject=EF=BC=9ARe: [PATCH] drm/imx/dcss: Fix clock leak on blkctl init fai=
lure

Hi,

Thank you for the fix.

On Fri, Oct 30, 2026 at 04:33:42PM +0800, laixiangwu wrote:
&gt; dcss_submodules_init() enables the DCSS clocks before initializing the
&gt; submodules, but if the first submodule (blkctl) fails to initialize th=
e
&gt; function returns directly, without disabling the clocks again. All the
&gt; later error paths already jump to ctxld_err, which calls
&gt; dcss_clocks_disable().
&gt;=20
&gt; Since the clocks are only devm-managed for their reference (devm_clk_g=
et),
&gt; a blkctl init failure leaves all five DCSS clocks prepared and enabled=
.
&gt;=20
&gt; Jump to ctxld_err so the clocks are disabled like on the other error
&gt; paths.
&gt;=20
&gt; Fixes: 9021c317b770 ("drm/imx: Add initial support for DCSS on iMX8MQ"=
)
&gt; Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>
&gt; ---
&gt;  drivers/gpu/drm/imx/dcss/dcss-dev.c | 2 +-
&gt;  1 file changed, 1 insertion(+), 1 deletion(-)
&gt;=20
&gt; diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.c b/drivers/gpu/drm/imx=
/dcss/dcss-dev.c
&gt; index 7fd0c4c14..551786060 100644
&gt; --- a/drivers/gpu/drm/imx/dcss/dcss-dev.c
&gt; +++ b/drivers/gpu/drm/imx/dcss/dcss-dev.c
&gt; @@ -70,7 +70,7 @@ static int dcss_submodules_init(struct dcss_dev *dcs=
s)
&gt;=20
&gt;         ret =3D dcss_blkctl_init(dcss, base_addr + devtype-&gt;blkctl_=
ofs);
&gt;         if (ret)
&gt; -               return ret;
&gt; +               goto ctxld_err;

With this change, now the label names I chose when I first developed this
driver don't feel right. Could you please send a v2 and rename those labels
below as well?

I'm thinking:
ctxld_err -&gt; err_clocks
dtg_err -&gt; err_ctxld
ss_err -&gt; err_dtg
dpr_err -&gt; err_ss
scaler_err -&gt; err_dpr

Update those 'goto' lines accordingly.

--=20
Thanks,
Laurentiu

</laixiangwu@cmss.chinamobile.com></laixiangwu@cmss.chinamobile.com></linux=
-kernel@vger.kernel.org></linux-arm-kernel@lists.infradead.org></imx@lists.=
linux.dev></dri-devel@lists.freedesktop.org></festevam@gmail.com></kernel@p=
engutronix.de></l.stach@pengutronix.de></s.hauer@pengutronix.de></frank.li@=
nxp.com></simona@ffwll.ch></airlied@gmail.com></tzimmermann@suse.de></mripa=
rd@kernel.org></maarten.lankhorst@linux.intel.com></laixiangwu@cmss.chinamo=
bile.com></laurentiu.palcu@oss.nxp.com><div style=3D"font-size: 16px; font-=
family: =E5=AE=8B=E4=BD=93; background-color: rgb(255, 255, 255); color: rg=
b(0, 0, 0); line-height: 1.5; overflow-wrap: break-word; word-break: break-=
all;"><br><br><br><br><br>&nbsp;</div>
------=_Part_774147_2058071162.1793358943045--


