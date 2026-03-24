Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A8CF4613D
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08A3F10E63D;
	Tue, 24 Mar 2026 09:12:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=139.com header.i=@139.com header.b="vzOqwIND";
	dkim-atps=neutral
X-Greylist: delayed 560 seconds by postgrey-1.36 at gabe;
 Tue, 24 Mar 2026 01:01:30 UTC
Received: from n169-110.mail.139.com (d255-143.mail.139.com [36.138.255.143])
 by gabe.freedesktop.org (Postfix) with ESMTP id 13BD510E2AB;
 Tue, 24 Mar 2026 01:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=139.com; s=dkim; l=0;
 h=from:subject:message-id:to:cc:mime-version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=vzOqwINDB91eV8+Xm8AYdJubgN2sv0Ozjh4V8rnqN+AbLd3z5AEVMBufOsr6WslFWxkSD/rqqMky9
 YbKHpJkK/VDWWeoQEqkEKscEMnwc69zwMFQLb6QT+ycKa6x3NZ9NKfDv2DqwtQ0VWN50FFmu0KY7C1
 zcWQPT5nr4bnc2dI=
X-RM-SAVE-FROM: 1
X-RM-SPAM-FLAG: 00000000
Received: from 1468888505@139.com ( [60.247.85.88] )
 by ajax-webmail-appmail_28-11028 (Richmail) with HTTP;
 Tue, 24 Mar 2026 08:52:01 +0800 (CST)
Date: Tue, 24 Mar 2026 08:52:01 +0800 (CST)
From: 18801328227 <1468888505@139.com>
To: Greg KH  <gregkh@linuxfoundation.org>, 
 =?utf-8?Q?ChristianK=C3=B6nig=20?= <christian.koenig@amd.com>
Cc: cve  <cve@kernel.org>, 
 "srinivasan.shanmugam " <srinivasan.shanmugam@amd.com>, 
 patches  <patches@lists.linux.dev>, 
 linux-kernel  <linux-kernel@vger.kernel.org>, 
 "alexander.deucher " <alexander.deucher@amd.com>, 
 "Xinhui.Pan " <Xinhui.Pan@amd.com>, airlied  <airlied@gmail.com>, 
 daniel  <daniel@ffwll.ch>, sashal  <sashal@kernel.org>, 
 "guchun.chen " <guchun.chen@amd.com>, 
 amd-gfx  <amd-gfx@lists.freedesktop.org>, 
 dri-devel  <dri-devel@lists.freedesktop.org>
Message-ID: <2b1469c1e031aed-00001.Richmail.02090755151412502065@139.com>
References: <20260323071052.4068410-1-1468888505@139.com>
 <f2d125ce-8cb9-4ae8-8f55-0b5a78e66f83@amd.com>
 <2026032346-ruse-dork-baf3@gregkh>
 <bd383c94-8350-420c-adbf-cc02a9918a37@amd.com>,
 <2026032335-muster-chump-60f7@gregkh>
Subject: Re:Re: [PATCH 6.1.y] drm/amdgpu: Fix potential out-of-bounds access
 in'amdgpu_discovery_reg_base_init()'
MIME-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="----=_Part_7137_44425550.1774313521908"
X-Priority: 3
X-RM-TRANSID: 2b1469c1e031aed-00001
X-RM-OA-ENC-TYPE: 0
X-RM-FontColor: 0
X-CLIENT-INFO: X-TIMING=0&X-MASSSENT=0&X-SENSITIVE=0
X-Mailer: Richmail_Webapp(V2.5.32)
X-Mailman-Approved-At: Tue, 24 Mar 2026 09:12:22 +0000
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

------=_Part_7137_44425550.1774313521908
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: quoted-printable



Hi Greg & Christian,

Thanks for pointing this out. You are correct! I submitted this patch solel=
y to fix CVE-2024-27042. I am happy to withdraw it. Thanks a lot.






---------------------------------------------------------------------------=
-----


----The following is the content of the forwarded email----
From=EF=BC=9AGreg KH=20
To=EF=BC=9A"ChristianK=C3=B6nig"=20
Date=EF=BC=9A2026-03-23 20:37:46
Subject=EF=BC=9ARe: [PATCH 6.1.y] drm/amdgpu: Fix potential out-of-bounds a=
ccess in'amdgpu_discovery_reg_base_init()'

On Mon, Mar 23, 2026 at 01:28:24PM +0100, Christian K=C3=B6nig wrote:
> Hi Greg,
>=20
> On 3/23/26 11:32, Greg KH wrote:
> > On Mon, Mar 23, 2026 at 10:51:18AM +0100, Christian K=C3=B6nig wrote:
> >> Hi Li,
> >>
> >> On 3/23/26 08:10, Li hongliang wrote:
> >>> From: Srinivasan Shanmugam=20
> >>>
> >>> [ Upstream commit cdb637d339572398821204a1142d8d615668f1e9 ]
> >>>
> >>> The issue arises when the array 'adev->vcn.vcn_config' is accessed
> >>> before checking if the index 'adev->vcn.num_vcn_inst' is within the
> >>> bounds of the array.
> >>>
> >>> The fix involves moving the bounds check before the array access. Thi=
s
> >>> ensures that 'adev->vcn.num_vcn_inst' is within the bounds of the arr=
ay
> >>> before it is used as an index.
> >>>
> >>> Fixes the below:
> >>> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1289 amdgpu_discovery_r=
eg_base_init() error: testing array offset 'adev->vcn.num_vcn_inst' after u=
se.
> >>
> >> well this patch only fixed a compiler warning and has not much practic=
al value otherwise.
> >>
> >> Why are you sending this for inclusion into the 6.1 kernel?
> >=20
> > Perhaps because it was assigned to CVE-2024-27042? If this is ONLY a
> > compiler warning fix, and NOT an actual vulnerability fix, please let
> > cve@kernel.org know about that and they will revoke this CVE.
>=20
> Thanks a lot for pointing that out, adding cve@kernel.org.
>=20
> As far as I can see the CVE-2024-27042 is not valid or at least not corre=
ctly categorized.
>=20
> It is correct that there is a potential array overrun in amdgpu_discovery=
_reg_base_init(), but that function is used to parse a VBIOS table from a f=
lash EEPROM located on the HW and not user input.
>=20
> If an attacker already had the ability to modify that EEPROM he could jus=
t overwrite the VBIOS code were parts are directly executed at bootup and/o=
r driver load. So this problem here wouldn't be needed at all.
>=20
> It is good that this warning is fixed, but as far as I can see there is n=
o reason whatsoever to backport it nor to assign a CVE entry for it.

Now rejected, thanks!

greg k-h















------=_Part_7137_44425550.1774313521908
Content-Type: text/html;charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div style=3D"font-family: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91; color: rgb=
(0, 0, 0); line-height: 1.5; overflow-wrap: break-word;"><div class=3D"qk-m=
d-paragraph" style=3D"-webkit-font-smoothing: antialiased; --tw-border-spac=
ing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-translate-y: =
0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-sc=
ale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-s=
trictness: proximity; --tw-gradient-from-position: ; --tw-gradient-via-posi=
tion: ; --tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed-zero: ; -=
-tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: ; --tw=
-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-color: #fff; -=
-tw-ring-color: rgba(59,130,246,.5); --tw-ring-offset-shadow: 0 0 transpare=
nt; --tw-ring-shadow: 0 0 transparent; --tw-shadow: 0 0 transparent; --tw-s=
hadow-colored: 0 0 transparent; --tw-blur: ; --tw-brightness: ; --tw-contra=
st: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-invert: ; --tw-saturate: ; =
--tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-blur: ; --tw-backdrop-brigh=
tness: ; --tw-backdrop-contrast: ; --tw-backdrop-grayscale: ; --tw-backdrop=
-hue-rotate: ; --tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdr=
op-saturate: ; --tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-lay=
out: ; --tw-contain-paint: ; --tw-contain-style: ; box-sizing: border-box; =
border: 0px solid; margin-top: 0px; margin-bottom: 16px; content-visibility=
: auto; contain-intrinsic-size: auto 30px; opacity: 1; color: rgb(6, 10, 38=
); font-family: 'PingFang SC', 'Helvetica Neue', system-ui, -apple-system, =
BlinkMacSystemFont, 'Segoe UI', Roboto, 'Noto Sans', Ubuntu, Cantarell, STH=
eiti, 'Microsoft Yahei', Simsun, Tahoma, 'Apple Color Emoji', 'Segoe UI Emo=
ji', 'Segoe UI Symbol', 'Noto Color Emoji', sans-serif; background-color: r=
gb(255, 255, 255); animation: auto ease 0s 1 normal none running none !impo=
rtant;"><span class=3D"qk-md-text complete" style=3D"-webkit-font-smoothing=
: antialiased; --tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-tra=
nslate-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew=
-y: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-p=
inch-zoom: ; --tw-scroll-snap-strictness: proximity; --tw-gradient-from-pos=
ition: ; --tw-gradient-via-position: ; --tw-gradient-to-position: ; --tw-or=
dinal: ; --tw-slashed-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: =
; --tw-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; =
--tw-ring-offset-color: #fff; --tw-ring-color: rgba(59,130,246,.5); --tw-ri=
ng-offset-shadow: 0 0 transparent; --tw-ring-shadow: 0 0 transparent; --tw-=
shadow: 0 0 transparent; --tw-shadow-colored: 0 0 transparent; --tw-blur: ;=
 --tw-brightness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; -=
-tw-invert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backd=
rop-blur: ; --tw-backdrop-brightness: ; --tw-backdrop-contrast: ; --tw-back=
drop-grayscale: ; --tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; --tw-=
backdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: ; --tw-c=
ontain-size: ; --tw-contain-layout: ; --tw-contain-paint: ; --tw-contain-st=
yle: ; box-sizing: border-box; border: 0px solid; opacity: 1; color: rgba(6=
, 10, 38, 0.7) !important; animation: auto ease 0s 1 normal none running no=
ne !important;"><font size=3D"3">Hi Greg &amp; Christian,</font></span></di=
v><div class=3D"qk-md-paragraph" data-spm-anchor-id=3D"5176.28103460.0.i3.6=
3d66308gQ31KT" style=3D"-webkit-font-smoothing: antialiased; --tw-border-sp=
acing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-translate-y=
: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-=
scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap=
-strictness: proximity; --tw-gradient-from-position: ; --tw-gradient-via-po=
sition: ; --tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed-zero: ;=
 --tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: ; --=
tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-color: #fff;=
 --tw-ring-color: rgba(59,130,246,.5); --tw-ring-offset-shadow: 0 0 transpa=
rent; --tw-ring-shadow: 0 0 transparent; --tw-shadow: 0 0 transparent; --tw=
-shadow-colored: 0 0 transparent; --tw-blur: ; --tw-brightness: ; --tw-cont=
rast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-invert: ; --tw-saturate: =
; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-blur: ; --tw-backdrop-bri=
ghtness: ; --tw-backdrop-contrast: ; --tw-backdrop-grayscale: ; --tw-backdr=
op-hue-rotate: ; --tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-back=
drop-saturate: ; --tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-l=
ayout: ; --tw-contain-paint: ; --tw-contain-style: ; box-sizing: border-box=
; border: 0px solid; margin-top: 0px; content-visibility: auto; contain-int=
rinsic-size: auto 30px; opacity: 1; color: rgb(6, 10, 38); font-family: 'Pi=
ngFang SC', 'Helvetica Neue', system-ui, -apple-system, BlinkMacSystemFont,=
 'Segoe UI', Roboto, 'Noto Sans', Ubuntu, Cantarell, STHeiti, 'Microsoft Ya=
hei', Simsun, Tahoma, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symb=
ol', 'Noto Color Emoji', sans-serif; background-color: rgb(255, 255, 255); =
margin-bottom: 0px !important; animation: auto ease 0s 1 normal none runnin=
g none !important;"><font size=3D"3"><span class=3D"qk-md-text complete" st=
yle=3D"-webkit-font-smoothing: antialiased; --tw-border-spacing-x: 0; --tw-=
border-spacing-y: 0; --tw-translate-x: 0; --tw-translate-y: 0; --tw-rotate:=
 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-=
pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-strictness: prox=
imity; --tw-gradient-from-position: ; --tw-gradient-via-position: ; --tw-gr=
adient-to-position: ; --tw-ordinal: ; --tw-slashed-zero: ; --tw-numeric-fig=
ure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: ; --tw-ring-inset: ; =
--tw-ring-offset-width: 0px; --tw-ring-offset-color: #fff; --tw-ring-color:=
 rgba(59,130,246,.5); --tw-ring-offset-shadow: 0 0 transparent; --tw-ring-s=
hadow: 0 0 transparent; --tw-shadow: 0 0 transparent; --tw-shadow-colored: =
0 0 transparent; --tw-blur: ; --tw-brightness: ; --tw-contrast: ; --tw-gray=
scale: ; --tw-hue-rotate: ; --tw-invert: ; --tw-saturate: ; --tw-sepia: ; -=
-tw-drop-shadow: ; --tw-backdrop-blur: ; --tw-backdrop-brightness: ; --tw-b=
ackdrop-contrast: ; --tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: ; =
--tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: ; =
--tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; --tw-con=
tain-paint: ; --tw-contain-style: ; box-sizing: border-box; border: 0px sol=
id; opacity: 1; color: rgba(6, 10, 38, 0.7) !important; animation: auto eas=
e 0s 1 normal none running none !important;">Thanks for&nbsp;</span><span c=
lass=3D"qk-md-strong complete" style=3D"-webkit-font-smoothing: antialiased=
; --tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; =
--tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-s=
cale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; =
--tw-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; --tw=
-gradient-via-position: ; --tw-gradient-to-position: ; --tw-ordinal: ; --tw=
-slashed-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeri=
c-fraction: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-off=
set-color: #fff; --tw-ring-color: rgba(59,130,246,.5); --tw-ring-offset-sha=
dow: 0 0 transparent; --tw-ring-shadow: 0 0 transparent; --tw-shadow: 0 0 t=
ransparent; --tw-shadow-colored: 0 0 transparent; --tw-blur: ; --tw-brightn=
ess: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-invert: ;=
 --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-blur: ; -=
-tw-backdrop-brightness: ; --tw-backdrop-contrast: ; --tw-backdrop-grayscal=
e: ; --tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; --tw-backdrop-opac=
ity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: ; --tw-contain-size: =
; --tw-contain-layout: ; --tw-contain-paint: ; --tw-contain-style: ; box-si=
zing: border-box; border: 0px solid; opacity: 1; animation: auto ease 0s 1 =
normal none running none !important;">pointing this out</span><span class=
=3D"qk-md-text complete" style=3D"-webkit-font-smoothing: antialiased; --tw=
-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-t=
ranslate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x=
: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --tw-s=
croll-snap-strictness: proximity; --tw-gradient-from-position: ; --tw-gradi=
ent-via-position: ; --tw-gradient-to-position: ; --tw-ordinal: ; --tw-slash=
ed-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-frac=
tion: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-co=
lor: #fff; --tw-ring-color: rgba(59,130,246,.5); --tw-ring-offset-shadow: 0=
 0 transparent; --tw-ring-shadow: 0 0 transparent; --tw-shadow: 0 0 transpa=
rent; --tw-shadow-colored: 0 0 transparent; --tw-blur: ; --tw-brightness: ;=
 --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-invert: ; --tw-=
saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-blur: ; --tw-ba=
ckdrop-brightness: ; --tw-backdrop-contrast: ; --tw-backdrop-grayscale: ; -=
-tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; --tw-backdrop-opacity: ;=
 --tw-backdrop-saturate: ; --tw-backdrop-sepia: ; --tw-contain-size: ; --tw=
-contain-layout: ; --tw-contain-paint: ; --tw-contain-style: ; box-sizing: =
border-box; border: 0px solid; opacity: 1; color: rgba(6, 10, 38, 0.7) !imp=
ortant; animation: auto ease 0s 1 normal none running none !important;">. Y=
ou are correct! I submitted this patch&nbsp;</span><span class=3D"qk-md-str=
ong complete" style=3D"-webkit-font-smoothing: antialiased; --tw-border-spa=
cing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-translate-y:=
 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-s=
cale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-=
strictness: proximity; --tw-gradient-from-position: ; --tw-gradient-via-pos=
ition: ; --tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed-zero: ; =
--tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: ; --t=
w-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-color: #fff; =
--tw-ring-color: rgba(59,130,246,.5); --tw-ring-offset-shadow: 0 0 transpar=
ent; --tw-ring-shadow: 0 0 transparent; --tw-shadow: 0 0 transparent; --tw-=
shadow-colored: 0 0 transparent; --tw-blur: ; --tw-brightness: ; --tw-contr=
ast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-invert: ; --tw-saturate: ;=
 --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-blur: ; --tw-backdrop-brig=
htness: ; --tw-backdrop-contrast: ; --tw-backdrop-grayscale: ; --tw-backdro=
p-hue-rotate: ; --tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backd=
rop-saturate: ; --tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-la=
yout: ; --tw-contain-paint: ; --tw-contain-style: ; box-sizing: border-box;=
 border: 0px solid; opacity: 1; animation: auto ease 0s 1 normal none runni=
ng none !important;">solely to fix</span><span class=3D"qk-md-text complete=
" style=3D"-webkit-font-smoothing: antialiased; --tw-border-spacing-x: 0; -=
-tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-translate-y: 0; --tw-rot=
ate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-scale-y: 1; -=
-tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-strictness: =
proximity; --tw-gradient-from-position: ; --tw-gradient-via-position: ; --t=
w-gradient-to-position: ; --tw-ordinal: ; --tw-slashed-zero: ; --tw-numeric=
-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: ; --tw-ring-inset=
: ; --tw-ring-offset-width: 0px; --tw-ring-offset-color: #fff; --tw-ring-co=
lor: rgba(59,130,246,.5); --tw-ring-offset-shadow: 0 0 transparent; --tw-ri=
ng-shadow: 0 0 transparent; --tw-shadow: 0 0 transparent; --tw-shadow-color=
ed: 0 0 transparent; --tw-blur: ; --tw-brightness: ; --tw-contrast: ; --tw-=
grayscale: ; --tw-hue-rotate: ; --tw-invert: ; --tw-saturate: ; --tw-sepia:=
 ; --tw-drop-shadow: ; --tw-backdrop-blur: ; --tw-backdrop-brightness: ; --=
tw-backdrop-contrast: ; --tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate=
: ; --tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate=
: ; --tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; --tw=
-contain-paint: ; --tw-contain-style: ; box-sizing: border-box; border: 0px=
 solid; opacity: 1; color: rgba(6, 10, 38, 0.7) !important; animation: auto=
 ease 0s 1 normal none running none !important;">&nbsp;CVE-2024-27042. I am=
&nbsp;</span><span class=3D"qk-md-strong complete" style=3D"-webkit-font-sm=
oothing: antialiased; --tw-border-spacing-x: 0; --tw-border-spacing-y: 0; -=
-tw-translate-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --=
tw-skew-y: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ;=
 --tw-pinch-zoom: ; --tw-scroll-snap-strictness: proximity; --tw-gradient-f=
rom-position: ; --tw-gradient-via-position: ; --tw-gradient-to-position: ; =
--tw-ordinal: ; --tw-slashed-zero: ; --tw-numeric-figure: ; --tw-numeric-sp=
acing: ; --tw-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-offset-width=
: 0px; --tw-ring-offset-color: #fff; --tw-ring-color: rgba(59,130,246,.5); =
--tw-ring-offset-shadow: 0 0 transparent; --tw-ring-shadow: 0 0 transparent=
; --tw-shadow: 0 0 transparent; --tw-shadow-colored: 0 0 transparent; --tw-=
blur: ; --tw-brightness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rota=
te: ; --tw-invert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --t=
w-backdrop-blur: ; --tw-backdrop-brightness: ; --tw-backdrop-contrast: ; --=
tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: ; --tw-backdrop-invert: =
; --tw-backdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: ;=
 --tw-contain-size: ; --tw-contain-layout: ; --tw-contain-paint: ; --tw-con=
tain-style: ; box-sizing: border-box; border: 0px solid; opacity: 1; animat=
ion: auto ease 0s 1 normal none running none !important;">happy to</span><s=
pan class=3D"qk-md-text complete" style=3D"-webkit-font-smoothing: antialia=
sed; --tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-translate-x: =
0; --tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --t=
w-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom:=
 ; --tw-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; -=
-tw-gradient-via-position: ; --tw-gradient-to-position: ; --tw-ordinal: ; -=
-tw-slashed-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-num=
eric-fraction: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-=
offset-color: #fff; --tw-ring-color: rgba(59,130,246,.5); --tw-ring-offset-=
shadow: 0 0 transparent; --tw-ring-shadow: 0 0 transparent; --tw-shadow: 0 =
0 transparent; --tw-shadow-colored: 0 0 transparent; --tw-blur: ; --tw-brig=
htness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-invert=
: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-blur: =
; --tw-backdrop-brightness: ; --tw-backdrop-contrast: ; --tw-backdrop-grays=
cale: ; --tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; --tw-backdrop-o=
pacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: ; --tw-contain-siz=
e: ; --tw-contain-layout: ; --tw-contain-paint: ; --tw-contain-style: ; box=
-sizing: border-box; border: 0px solid; opacity: 1; color: rgba(6, 10, 38, =
0.7) !important; animation: auto ease 0s 1 normal none running none !import=
ant;">&nbsp;withdraw it. Thanks a lot.</span></font></div></div><div style=
=3D"font-family: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91; font-size: 16px; col=
or: #000000; line-height: 1.5; overflow-wrap: break-word; "><br><br></div><=
hr id=3D"replySplit" style=3D"font-family: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=
=BB=91; font-size: 16px; color: rgb(0, 0, 0); line-height: 1.5;"><div id=3D=
"reply139content" style=3D"position: relative; font-family: =E5=BE=AE=E8=BD=
=AF=E9=9B=85=E9=BB=91; font-size: 16px; color: rgb(0, 0, 0); line-height: 1=
.5;" "=3D""><div id=3D"mainReplyContent">----The following is the content o=
f the forwarded email----
From=EF=BC=9AGreg KH  <gregkh@linuxfoundation.org>
To=EF=BC=9A"ChristianK=C3=B6nig" <christian.koenig@amd.com>
Date=EF=BC=9A2026-03-23 20:37:46
Subject=EF=BC=9ARe: [PATCH 6.1.y] drm/amdgpu: Fix potential out-of-bounds a=
ccess in'amdgpu_discovery_reg_base_init()'

On Mon, Mar 23, 2026 at 01:28:24PM +0100, Christian K=C3=B6nig wrote:
&gt; Hi Greg,
&gt;=20
&gt; On 3/23/26 11:32, Greg KH wrote:
&gt; &gt; On Mon, Mar 23, 2026 at 10:51:18AM +0100, Christian K=C3=B6nig wr=
ote:
&gt; &gt;&gt; Hi Li,
&gt; &gt;&gt;
&gt; &gt;&gt; On 3/23/26 08:10, Li hongliang wrote:
&gt; &gt;&gt;&gt; From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
&gt; &gt;&gt;&gt;
&gt; &gt;&gt;&gt; [ Upstream commit cdb637d339572398821204a1142d8d615668f1e=
9 ]
&gt; &gt;&gt;&gt;
&gt; &gt;&gt;&gt; The issue arises when the array 'adev-&gt;vcn.vcn_config'=
 is accessed
&gt; &gt;&gt;&gt; before checking if the index 'adev-&gt;vcn.num_vcn_inst' =
is within the
&gt; &gt;&gt;&gt; bounds of the array.
&gt; &gt;&gt;&gt;
&gt; &gt;&gt;&gt; The fix involves moving the bounds check before the array=
 access. This
&gt; &gt;&gt;&gt; ensures that 'adev-&gt;vcn.num_vcn_inst' is within the bo=
unds of the array
&gt; &gt;&gt;&gt; before it is used as an index.
&gt; &gt;&gt;&gt;
&gt; &gt;&gt;&gt; Fixes the below:
&gt; &gt;&gt;&gt; drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1289 amdgpu=
_discovery_reg_base_init() error: testing array offset 'adev-&gt;vcn.num_vc=
n_inst' after use.
&gt; &gt;&gt;
&gt; &gt;&gt; well this patch only fixed a compiler warning and has not muc=
h practical value otherwise.
&gt; &gt;&gt;
&gt; &gt;&gt; Why are you sending this for inclusion into the 6.1 kernel?
&gt; &gt;=20
&gt; &gt; Perhaps because it was assigned to CVE-2024-27042?  If this is ON=
LY a
&gt; &gt; compiler warning fix, and NOT an actual vulnerability fix, please=
 let
&gt; &gt; cve@kernel.org know about that and they will revoke this CVE.
&gt;=20
&gt; Thanks a lot for pointing that out, adding cve@kernel.org.
&gt;=20
&gt; As far as I can see the CVE-2024-27042 is not valid or at least not co=
rrectly categorized.
&gt;=20
&gt; It is correct that there is a potential array overrun in amdgpu_discov=
ery_reg_base_init(), but that function is used to parse a VBIOS table from =
a flash EEPROM located on the HW and not user input.
&gt;=20
&gt; If an attacker already had the ability to modify that EEPROM he could =
just overwrite the VBIOS code were parts are directly executed at bootup an=
d/or driver load. So this problem here wouldn't be needed at all.
&gt;=20
&gt; It is good that this warning is fixed, but as far as I can see there i=
s no reason whatsoever to backport it nor to assign a CVE entry for it.

Now rejected, thanks!

greg k-h
</srinivasan.shanmugam@amd.com></christian.koenig@amd.com></gregkh@linuxfou=
ndation.org></div><div contenteditable=3D"false"></div></div><div style=3D"=
font-family: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91; font-size: 16px; color: =
#000000; line-height: 1.5; overflow-wrap: break-word; "><br><br><br><br><br=
><br></div><div id=3D"signContainer" style=3D"font-family: =E5=BE=AE=E8=BD=
=AF=E9=9B=85=E9=BB=91; font-size: 16px; color: rgb(0, 0, 0); line-height: 1=
.5;"></div>
------=_Part_7137_44425550.1774313521908--

