Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530A3C624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1935510E4F0;
	Thu,  3 Sep 2026 07:33:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TNJoY7R0";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 307D310EF25
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 20:25:36 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4843e9c5960so344009f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 13:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788294334; cv=none;
 d=google.com; s=arc-20260327;
 b=G/z1tGd/Hw6aUknXzAVCalEDPgzmVqoVr4FkZNUVYhu5ov154r33HuB8qqfcb00/P7
 UpaClmpO1D6inbLc+XnskrPzKnuMMC2CP3QsCRANknGeF5yn6NPdlOoZ7rxzRV2SD1s/
 CL0n4/VN+vcdLRuo2qNod+uvo/JUkonkNcGP8KB8ydWyPIJ4veGqWqO+/utTA8KX7fbx
 QcxNPC28un8otanO/SwPmrMWhFUl71HiAsvu0YSabdMV50xt4mtVRG9QmG2j/2gPka1V
 ulD/bx6sJx3BCivpwE0sa6HymRhVuGk48v7XFwpcq+XmHcFVIIomAE7bkzOyWew9aNs3
 xbYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kosM5dha8NkTtYCfXlSXpW490mZTBLt5WdaR6VaVdj0=;
 fh=0+ESy+WTqTtyeYyCL5VZ+V6ty2ZFW54XkZ5y1FaM6QY=;
 b=BleAOQ4yABOWWhR/j5uaudbmQiaN6h+8GELuAOncoF5AJicXu3K+Vlq9Gl0zfGjQ7J
 YJUfMa4d6kNenHioO0uxyNZjlNeigq7d6K6U3jXDGUD1BpDxXZCMy4ysnAeCvl7zHRta
 JAtF3ZT02Tu4iRi9Q+hfj/CG0qBz4pophM+RvEm2lomK7G5t1mBRpznXL0A1B4o8Foaj
 rum99sMyIhoU5P57mUFYp6S57OHn1KtvNIQR9uQd4aqiYNjKrpDVWclCxG2E81hZTYcG
 9IiiW2b9g6aQ+lDDD/QVqo3eIITYAmb3ALAKv80/Qm+wRmVx0JdutF/vm3gFInm80Kgy
 2hMA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788294334; x=1788899134; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kosM5dha8NkTtYCfXlSXpW490mZTBLt5WdaR6VaVdj0=;
 b=TNJoY7R0BAt1espEKPEMu7KBQ0KMKtjRGr/Td1ZsUVN4+kOqtlz79vhs4Ezd0hnIzm
 1feq7BIjIHvfZeT975LxXy/o9MuGEQV5c3VSf+DpO+Sm6pBVhcBU98e8Ijl8Dyg9aZ7v
 1cQ0BACc0e4ri8RP3mjft4czqSB93UvOMeG/hkTgw5LYBODXKnpWzywlEX4oA5ttAqCY
 ydVs5R0A/sTHFbb0EWyggd6UmkiWihVzyH8YCr9q9FnIgAIpfPvo80XVurpVlJm+MJqy
 w7CcuRUstAGyjHWGVgBRtES+ZsoBi/ZCXiKXplmTioz8am344H5A0NAuRhpOWOBotaB8
 FUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294334; x=1788899134;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kosM5dha8NkTtYCfXlSXpW490mZTBLt5WdaR6VaVdj0=;
 b=Hm2osazNnUPjXBdxzmMelw50k8lHjbmLY6DoH/65D3auK5vSKMCEVa+QtKlr7KV2iP
 SdgSH/Dt9O+7Cxe22lMmiADpXTJwIkIAkbFloNG5QRF90UF9h2wm4sN5xTI4hOS2wx2Y
 nOLy7h7IqyfzPJDZ4S/x/LgWet5s1PSy2Gic+2d+dqRHkFfmzm0Ypu7Ijo4qvKj350If
 oQzn7ZISos9pHNq6vxFdzBAeyHIs9jqhsp9OU5OAHaeh2wSPE3IkXpVdFSHvj6oS5aHe
 7+R9MEkc+Ya3cLiXr1OHiZMM9Z67jL+k+rcsRbnv38tdw8DP+vMnlkluZJvSNRoo532Y
 ZFeg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+x7JbjcW3C5OCkpWBIeF+Onl9/bcUfdJ04BpLvD8Ea0L8odE+Oa9lj5yQR8PpPNMKlzM1QDZ+3Mo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k22T4uC+OYSCmlZ+tTX5H1EWjukebdV8LRGGOOx4Q9+dKsQM0u
 EREz9MTqNt4/fYuttNM4Dik5apmYbumiPOhvvuCPwsKJVqzPS5Os0qjb2cjOnJF11OYh6xLHt16
 o61jtamPMT9b+6c0Iy1/Sey1IvjWQWZk=
X-Gm-Gg: AYBFou07MzViySIQC+SHyTXjCN8hGh13m44ZGG2fo7JQVQVeRd0YN5b0WATELOKFRQ/
 22d3PNpPYlX7W135m2Us3qoa5t6VC9laMJTHXUcWH5qDZ/KAD+bGZYG5Tadg7hXVEVTGSYyGk/S
 0IWYosdBn8tUw9mjBwx6keJW2MyrhX6nayPzGnK3zCLrETdhTLhCeWPaXUuwErf+LbTW4VZG4H8
 GtPcEq6NP+BnfzM3iICnSbraOzAKlLUMP1oVCdMegpClwDKciapLPH9qhOsWjqkVExw+sk9t3pu
 S1P0vDefDGFvdX+z3/zqPwxz29lnM0/kn8NFvoynxAIIeEp3PF9LcVdllFvNkeU0U54hupNele2
 Sg3DTfblkjAhhA68VC83xI7Y+bOuVV/A3I7NbnCPlD8bREEcxmdxHiat66bx0K+DcMYdWq3oT
X-Received: by 2002:a05:6000:2510:b0:483:ca4a:6b9d with SMTP id
 ffacd0b85a97d-483ca4a6d9cmr43063214f8f.20.1788294334255; Tue, 01 Sep 2026
 13:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260811003921.1398292-1-jerry.zuo@amd.com>
 <20260814164344.3098143-1-jerry.zuo@amd.com>
 <c42ced8f-5e3a-42c9-ade4-d357575114ca@gmail.com>
 <CHXPR12MB999220744D9CB11795CEF3DD69E5A82@CHXPR12MB999220.namprd12.prod.outlook.com>
In-Reply-To: <CHXPR12MB999220744D9CB11795CEF3DD69E5A82@CHXPR12MB999220.namprd12.prod.outlook.com>
From: Adolfo Rodrigues <adolfotregosa@gmail.com>
Date: Tue, 1 Sep 2026 21:25:22 +0100
X-Gm-Features: AcwNN1URQfLVw4EHFPtzeFf2phN00tM7fomNPQpKXd1HaLzAhcL832U3-EgVK1w
Message-ID: <CA+gx7Ur5-s7gSEn2xHY99qh6McLxWAJQKWCMg8Li+58zA336iQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] HDMI 2.1 VRR and ALLM support
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>, 
 =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>, 
 "daniel@fooishbar.org" <daniel@fooishbar.org>
Content-Type: multipart/alternative; boundary="0000000000008c18ca065a71b867"
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

--0000000000008c18ca065a71b867
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I patched kernel 7.3-rc1 with the passive-VRR patches, but VRR is not
engaging while on the desktop.

On Tue, Sep 1, 2026 at 8:16=E2=80=AFPM Zuo, Jerry <Jerry.Zuo@amd.com> wrote=
:

> AMD General
>
> > -----Original Message-----
> > From: Adolfo <adolfotregosa@gmail.com>
> > Sent: Monday, August 31, 2026 14:49
> > To: Zuo, Jerry <Jerry.Zuo@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org; Wentland, Harry
> > <Harry.Wentland@amd.com>; Tomasz Paku=C5=82a
> > <tomasz.pakula.oficjalny@gmail.com>; daniel@fooishbar.org
> > Subject: Re: [PATCH v4 0/4] HDMI 2.1 VRR and ALLM support
> >
> > [You don't often get email from adolfotregosa@gmail.com. Learn why this
> is
> > important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > I patched kernel 7.3-rc1, and I have KDE's Adaptive Sync property set t=
o
> > Automatic (Always makes the display gamma flicker). VRR itself is only
> > engaged when entering a game.
> >
> > My display (an LG C1 connected through an Onkyo RZ70 AVR) shows "fixed"
> > when VRR is not active. While this seems logical, it causes the display
> to go
> > blank every time I enter or exit a game, or, even worse, when I alt-tab
> while in
> > a game.
> >
> > In my case, I can have periods of up to 10 seconds with no image while
> the
> > devices in the HDMI chain disagree with each other, and sometimes I los=
e
> the
> > image completely.
> >
> > A kernel parameter to force VRR to always be enabled should be availabl=
e.
> > This would prevent these signal-switching problems, and it is how
> "FreeSync"
> > actually works and also with the unofficial kernel patches for AMD HDMI
> 2.1
> > + VRR on kernel 7.2.
> >
> > There is also some evidence that keeping VRR active can avoid the mode-
> > switch behavior seen on some TVs when VRR is enabled or disabled.
>
> Thanks for your feedback. Regarding to your concern, I've uploaded anothe=
r
> series of patches for "passive VRR". Please check and see if that works
> for you.
>
> Regards,
> Jerry
>
> >
> > On 14/08/2026 17:43, Fangzhi Zuo wrote:
> > > This series adds HDMI 2.1 gaming support to amdgpu: Variable Refresh
> > > Rate
> > > (VRR) derived from the HDMI Forum VSDB (HF-VSDB), and Auto Low-
> > Latency
> > > Mode (ALLM). It builds on a drm/edid patch that parses the HF-VSDB
> > > gaming capabilities into struct drm_hdmi_info.
> > >
> > >    - Patch 1 reports FreeSync from the AMD VSDB (existing mechanism).
> > >    - Patch 2 (drm/edid) parses the HF-VSDB VRR range and ALLM bit.
> > >    - Patch 3 enables VRR from the HF-VSDB when the AMD VSDB has no
> > range.
> > >    - Patch 4 signals ALLM_Mode in the HF-VSIF when Gaming-VRR is
> active.
> > >
> > > v1:
> > > https://lore.kernel.org/amd-gfx/20260730171754.704049-1-jerry.zuo@amd=
.
> > > com/
> > > v2:
> > > https://lore.kernel.org/amd-gfx/20260806205449.16806-1-jerry.zuo@amd.=
c
> > > om/
> > > v3:
> > > https://lore.kernel.org/amd-gfx/20260811003921.1398292-1-
> > jerry.zuo@amd
> > > .com/
> > >
> > > Changes since v3:
> > >    - Drop the content-type based ALLM heuristic. ALLM_Mode is now set
> > only
> > >      for the mandatory Gaming-VRR case (VRR_EN=3D1 with a sink that
> > advertises
> > >      ALLM), per HDMI 2.1 Section 7.6.6; it is no longer derived from
> the
> > >      content type.
> > >
> > > Changes since v2:
> > >    - Fix coding-style issues in the VTEM info-packet code.
> > >
> > > Fangzhi Zuo (3):
> > >    drm/amd/display: Add 2.1 FreeSync support for AMD VSDB EDID Block
> > >    drm/amd/display: Add HDMI 2.1 VRR support from HF-VSDB
> > >    drm/amd/display: Enable HDMI ALLM for Gaming-VRR
> > >
> > > Tomasz Paku=C5=82a (1):
> > >    drm/edid: parse HDMI 2.1 gaming (ALLM/VRR) capabilities from
> > > HF-VSDB
> > >
> > >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   5 +-
> > >   .../display/amdgpu_dm/amdgpu_dm_connector.c   |  71 +++++++++++-
> > >   .../display/amdgpu_dm/amdgpu_dm_freesync.c    |  41 +++++++
> > >   .../amd/display/modules/inc/mod_info_packet.h |   4 +
> > >   .../display/modules/info_packet/info_packet.c | 109
> ++++++++++++++++++
> > >   drivers/gpu/drm/drm_edid.c                    |  42 +++++++
> > >   include/drm/drm_connector.h                   |  47 ++++++++
> > >   7 files changed, 317 insertions(+), 2 deletions(-)
> > >
> > >
> > > base-commit: de2622bbc20276eaaaafa8fdbd374ace1ced28dc
>

--0000000000008c18ca065a71b867
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">I patched kernel 7.3-rc1 with the passive=
-VRR patches, but VRR is not engaging while on the desktop.</div><div dir=
=3D"ltr"><br></div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gma=
il_attr">On Tue, Sep 1, 2026 at 8:16=E2=80=AFPM Zuo, Jerry &lt;<a href=3D"m=
ailto:Jerry.Zuo@amd.com" target=3D"_blank">Jerry.Zuo@amd.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">AMD General<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Adolfo &lt;<a href=3D"mailto:adolfotregosa@gmail.com" target=3D"=
_blank">adolfotregosa@gmail.com</a>&gt;<br>
&gt; Sent: Monday, August 31, 2026 14:49<br>
&gt; To: Zuo, Jerry &lt;<a href=3D"mailto:Jerry.Zuo@amd.com" target=3D"_bla=
nk">Jerry.Zuo@amd.com</a>&gt;; <a href=3D"mailto:amd-gfx@lists.freedesktop.=
org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a><br>
&gt; Cc: <a href=3D"mailto:dri-devel@lists.freedesktop.org" target=3D"_blan=
k">dri-devel@lists.freedesktop.org</a>; Wentland, Harry<br>
&gt; &lt;<a href=3D"mailto:Harry.Wentland@amd.com" target=3D"_blank">Harry.=
Wentland@amd.com</a>&gt;; Tomasz Paku=C5=82a<br>
&gt; &lt;<a href=3D"mailto:tomasz.pakula.oficjalny@gmail.com" target=3D"_bl=
ank">tomasz.pakula.oficjalny@gmail.com</a>&gt;; <a href=3D"mailto:daniel@fo=
oishbar.org" target=3D"_blank">daniel@fooishbar.org</a><br>
&gt; Subject: Re: [PATCH v4 0/4] HDMI 2.1 VRR and ALLM support<br>
&gt;<br>
&gt; [You don&#39;t often get email from <a href=3D"mailto:adolfotregosa@gm=
ail.com" target=3D"_blank">adolfotregosa@gmail.com</a>. Learn why this is<b=
r>
&gt; important at <a href=3D"https://aka.ms/LearnAboutSenderIdentification"=
 rel=3D"noreferrer" target=3D"_blank">https://aka.ms/LearnAboutSenderIdenti=
fication</a> ]<br>
&gt;<br>
&gt; I patched kernel 7.3-rc1, and I have KDE&#39;s Adaptive Sync property =
set to<br>
&gt; Automatic (Always makes the display gamma flicker). VRR itself is only=
<br>
&gt; engaged when entering a game.<br>
&gt;<br>
&gt; My display (an LG C1 connected through an Onkyo RZ70 AVR) shows &quot;=
fixed&quot;<br>
&gt; when VRR is not active. While this seems logical, it causes the displa=
y to go<br>
&gt; blank every time I enter or exit a game, or, even worse, when I alt-ta=
b while in<br>
&gt; a game.<br>
&gt;<br>
&gt; In my case, I can have periods of up to 10 seconds with no image while=
 the<br>
&gt; devices in the HDMI chain disagree with each other, and sometimes I lo=
se the<br>
&gt; image completely.<br>
&gt;<br>
&gt; A kernel parameter to force VRR to always be enabled should be availab=
le.<br>
&gt; This would prevent these signal-switching problems, and it is how &quo=
t;FreeSync&quot;<br>
&gt; actually works and also with the unofficial kernel patches for AMD HDM=
I 2.1<br>
&gt; + VRR on kernel 7.2.<br>
&gt;<br>
&gt; There is also some evidence that keeping VRR active can avoid the mode=
-<br>
&gt; switch behavior seen on some TVs when VRR is enabled or disabled.<br>
<br>
Thanks for your feedback. Regarding to your concern, I&#39;ve uploaded anot=
her<br>
series of patches for &quot;passive VRR&quot;. Please check and see if that=
 works for you.<br>
<br>
Regards,<br>
Jerry<br>
<br>
&gt;<br>
&gt; On 14/08/2026 17:43, Fangzhi Zuo wrote:<br>
&gt; &gt; This series adds HDMI 2.1 gaming support to amdgpu: Variable Refr=
esh<br>
&gt; &gt; Rate<br>
&gt; &gt; (VRR) derived from the HDMI Forum VSDB (HF-VSDB), and Auto Low-<b=
r>
&gt; Latency<br>
&gt; &gt; Mode (ALLM). It builds on a drm/edid patch that parses the HF-VSD=
B<br>
&gt; &gt; gaming capabilities into struct drm_hdmi_info.<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 - Patch 1 reports FreeSync from the AMD VSDB (existi=
ng mechanism).<br>
&gt; &gt;=C2=A0 =C2=A0 - Patch 2 (drm/edid) parses the HF-VSDB VRR range an=
d ALLM bit.<br>
&gt; &gt;=C2=A0 =C2=A0 - Patch 3 enables VRR from the HF-VSDB when the AMD =
VSDB has no<br>
&gt; range.<br>
&gt; &gt;=C2=A0 =C2=A0 - Patch 4 signals ALLM_Mode in the HF-VSIF when Gami=
ng-VRR is active.<br>
&gt; &gt;<br>
&gt; &gt; v1:<br>
&gt; &gt; <a href=3D"https://lore.kernel.org/amd-gfx/20260730171754.704049-=
1-jerry.zuo@amd" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.o=
rg/amd-gfx/20260730171754.704049-1-jerry.zuo@amd</a>.<br>
&gt; &gt; com/<br>
&gt; &gt; v2:<br>
&gt; &gt; <a href=3D"https://lore.kernel.org/amd-gfx/20260806205449.16806-1=
-jerry.zuo@amd.c" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.=
org/amd-gfx/20260806205449.16806-1-jerry.zuo@amd.c</a><br>
&gt; &gt; om/<br>
&gt; &gt; v3:<br>
&gt; &gt; <a href=3D"https://lore.kernel.org/amd-gfx/20260811003921.1398292=
-1-" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/amd-gfx/2=
0260811003921.1398292-1-</a><br>
&gt; jerry.zuo@amd<br>
&gt; &gt; .com/<br>
&gt; &gt;<br>
&gt; &gt; Changes since v3:<br>
&gt; &gt;=C2=A0 =C2=A0 - Drop the content-type based ALLM heuristic. ALLM_M=
ode is now set<br>
&gt; only<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 for the mandatory Gaming-VRR case (VRR_EN=3D1=
 with a sink that<br>
&gt; advertises<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 ALLM), per HDMI 2.1 Section 7.6.6; it is no l=
onger derived from the<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 content type.<br>
&gt; &gt;<br>
&gt; &gt; Changes since v2:<br>
&gt; &gt;=C2=A0 =C2=A0 - Fix coding-style issues in the VTEM info-packet co=
de.<br>
&gt; &gt;<br>
&gt; &gt; Fangzhi Zuo (3):<br>
&gt; &gt;=C2=A0 =C2=A0 drm/amd/display: Add 2.1 FreeSync support for AMD VS=
DB EDID Block<br>
&gt; &gt;=C2=A0 =C2=A0 drm/amd/display: Add HDMI 2.1 VRR support from HF-VS=
DB<br>
&gt; &gt;=C2=A0 =C2=A0 drm/amd/display: Enable HDMI ALLM for Gaming-VRR<br>
&gt; &gt;<br>
&gt; &gt; Tomasz Paku=C5=82a (1):<br>
&gt; &gt;=C2=A0 =C2=A0 drm/edid: parse HDMI 2.1 gaming (ALLM/VRR) capabilit=
ies from<br>
&gt; &gt; HF-VSDB<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |=C2=A0=
 =C2=A05 +-<br>
&gt; &gt;=C2=A0 =C2=A0.../display/amdgpu_dm/amdgpu_dm_connector.c=C2=A0 =C2=
=A0|=C2=A0 71 +++++++++++-<br>
&gt; &gt;=C2=A0 =C2=A0.../display/amdgpu_dm/amdgpu_dm_freesync.c=C2=A0 =C2=
=A0 |=C2=A0 41 +++++++<br>
&gt; &gt;=C2=A0 =C2=A0.../amd/display/modules/inc/mod_info_packet.h |=C2=A0=
 =C2=A04 +<br>
&gt; &gt;=C2=A0 =C2=A0.../display/modules/info_packet/info_packet.c | 109 +=
+++++++++++++++++<br>
&gt; &gt;=C2=A0 =C2=A0drivers/gpu/drm/drm_edid.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 42 +++++++<br>
&gt; &gt;=C2=A0 =C2=A0include/drm/drm_connector.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 47 ++++++++<br>
&gt; &gt;=C2=A0 =C2=A07 files changed, 317 insertions(+), 2 deletions(-)<br=
>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; base-commit: de2622bbc20276eaaaafa8fdbd374ace1ced28dc<br>
</blockquote></div>
</div>

--0000000000008c18ca065a71b867--
