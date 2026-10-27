Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D0F606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=slax.org header.i=@slax.org header.a=rsa-sha256 header.s=google header.b=aGqurVpD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA511112036;
	Thu, 29 Oct 2026 07:58:57 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4794710E470
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 19:20:49 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-3ab3b29a1d0so1180941fa.2
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 12:20:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793128848; cv=none;
 d=google.com; s=arc-20260327;
 b=T73hkD2WyH8253wiEr2lRSOT++LF4ItFAxO80vpPv4GdEZn7v4VAxkzTjNRrwaqVcr
 Oh7ROjx0rw4CGXZDPrQFj9MPbgiSBko0LJm/TLzHxDX+55VgnlG7cTEwuzyAA11kdHla
 rC7gmRUdk8HQ5qOp7vhGqArWXfcMu3L/duY+2u1uAI8zDbg0YtO0SpbdWZdy07rNhzXq
 4tRHgJRFK+fRvTxz9UuR+ynDyfvQVrNuFGH87CuQYWbkHqTGbtssnL2ObGmGDCbp80YS
 3Flw2M+vhTxguAd6nDDldAfRjFnl3OPd0mq440aSMYABHAu1VwIW7AR9Zvi1fc+XUnmn
 /Qmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BmBx2pTqdT74yYi9LedFri9RGsqn0IpXKa62wC7Tj5A=;
 fh=qTtUDTRjTXScrUzF1cmiYUs9V3+BmDlECXJOElBt5Lg=;
 b=iRtSM1jVBobi5ljnb/KwahxCeY0169BzLj1H898jvU6eElbB9z51AyrrNBMYknDlh9
 He9mmCbbcDwmvAjKhkkcQnMGj7dtPvmV/2chLbcrDlqDIGD0pDQ8gOoRDI5W5IhcordA
 pfOuo3f6z3GE/9jxUYxOQBqwLwOImncTj5dL3/bMAtdmdU73jBiWoBD47gQWCOf6SuzW
 EukLFp3yRf3ouPgpscfnGoT8SMeUcppxrk5d5/kDlUS9XRl1Ez1KxXqakM2IVy81hgJh
 NUdI/NaVmvDl6wVx1OUyEboEWuA75cMyu7O0cTlP1O6ozpsG0JIBXCFaQCYgNtMJ9ozB
 xDGw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=slax.org; s=google; t=1793128848; x=1793733648; darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BmBx2pTqdT74yYi9LedFri9RGsqn0IpXKa62wC7Tj5A=;
 b=aGqurVpDvIwuHEnT9ADrswJrgCZkM19WN2eNcXhEDMPjb0u32UA2nGW4unwg1y016y
 xtgeCMfrRFuWpeqvoE5rYaj7KQCXhMhsMQEHjYg+iWOVbtNqWznuDn5bafjZL40Dh08S
 MWtdZBIwtFnE6g7pW5MpzBfbvItFI3KDcd6wSWzcZ94DN27W0rEf1hxfKPiFBEm2Y05/
 aBbhYNBnqvFZn5Y71Wg9ZU9U8bKXBh81vRZfGO6/8xySCnzrfiC4YRguYT8a6jB4PCNd
 Zc2931cKAznGanG9E8wA20PDw4a1E14BFMbdrpjuZunN/vMm61xrFeuj36uHKfeKuIXN
 YhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793128848; x=1793733648;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BmBx2pTqdT74yYi9LedFri9RGsqn0IpXKa62wC7Tj5A=;
 b=1RmcK8ldC+xs7jmuLrSiKJHSllPUiF+iwUusSBqagEhvQIJCwyUDD5RWm7hBIUOi2f
 f36DVJd6VFRe3Ml07cCqNX/xJzXvFlbYhieSd1Liu2PbbuBtTpvdeeZeYGAuLLDEhDtI
 cZ08CPBMFOSAUP6Q0/vxk4W94Ab94qrDaCipifBNNVEMwGl8X6mhxXzIfoVZ+SrdDG4z
 wWctRaYD+Z1/TzHySac0H0L3lO6iZ9jc4eM4K3gm/7yC6RIl8veGSZdOjI4jobN+1vzl
 Q5Fv7A4DLrtWHa7cfYgqT/DSsZ14ErQnx+UUCHERWLIX2RS7aNxyjVil765s7AUnbbBa
 /67w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlAcxRnZpWIxHQbfVE6pJFYw7sD4p33j9fsg5eUsMKbZMbWOKlUChOYko2D+ASsXtMpPNqyOMtO3A=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKUaKFP9ILOLbGkPy4LARDcFtIhKSWL6ThcSzFMwBn5dzoo+HJ5
 sLCG2mojMYICAEV1wu2oeDvZ1suejz5lkwMzn3lN5rTEhUPp7UuqEFxvu8xzEjww6qm6JbTXuAF
 sOZDygEsKG3TNydUIDNIs3kJVVNdEZ5iwBhGDIQ5qVQ==
X-Gm-Gg: AYBFou1SiYXP31c7iUI0E8tu4B65mH5P5fNGjmk0ohZdgkKaxPnDRx9xHMrrB8iejS8
 U9OtE4Ic3zo221AJOhfJf9cHmhLPP/kg+nnLkMNZt/YenMTfDTJS6xxXBtcF4n8pNGub6QSfsGz
 l9jZS1bl4PkkbKAkGXQsThQQBTa+sMj8HRXInzH3Pusxt7UjWIKvGBEwek11Q2KoBy/l4jg4TeM
 Jiq8PIqRWy3Hag9/Nl9qeTmEVgHuW7DMbp1JqwD5cjzBQK2HH5rcXkIprGwpLAmlADud5gObGQe
 +BNtpEdRKl0nWBkj5gedh+iblMYGeNw0FaaZ48stxwuDNwdms0/QyGEnTs5ICPoyyGk12VrkrEa
 OSIt6w1efzKQBfj+nhMsnDuIxLtBYLRElOe7sjp87uw3+AwSMJrkKIFTkqpS5h7zPKMkCp1u1xd
 yWYUsTEuF/zSZD
X-Received: by 2002:a2e:9a0f:0:b0:3a9:740d:51cb with SMTP id
 38308e7fff4ca-3ac9cf41afamr91061fa.14.1793128847593; Tue, 27 Oct 2026
 12:20:47 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAL1oBhpCSzXmPDRLeyJW443ocXyZizkFnzDLQz44BRPPTv0reg@mail.gmail.com>
 <CAL1oBhoT+F+On=d5m=Jofmee81kPsFv5mc8z1-rst1krCX71EA@mail.gmail.com>
 <CABQX2QMQcQRUCjFOLtanOY-BsL-MQXwqLwkG1ZHEnW6GvLCXjw@mail.gmail.com>
In-Reply-To: <CABQX2QMQcQRUCjFOLtanOY-BsL-MQXwqLwkG1ZHEnW6GvLCXjw@mail.gmail.com>
From: Tomas M <tomas@slax.org>
Date: Tue, 27 Oct 2026 20:20:37 +0100
X-Gm-Features: AclHuK-ATw2OcDtNPwpct9mFf87r01Bz5KyEl9tO3W7yRLnLKXyTeTQ5WUZoIrQ
Message-ID: <CAL1oBhrxVaiR=vsoDa43wO4CsgZ3w-Rst+Dib2Gxvu+frj=4oQ@mail.gmail.com>
Subject: Re: [BUG] drm/vmwgfx: GB_ONLY cursor updates ignore legacy Xorg
 hotspot
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Ian Forbes <ian.forbes@broadcom.com>, dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000ff6263065ed7575a"
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000ff6263065ed7575a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for working on these fixes. Please feel free to include
vmwgfx-legacy-cursor-hotspot.patch in your series. You have my permission
to add my Signed-off-by, or you can use the patch even without mentioning
my name, I dont mind.

I'm happy to leave the details to you. My main goal is to get the bugs
fixed.

Thanks again.

Tomas M



Dne =C3=BAt 27. 10. 2026 20:00 u=C5=BEivatel Zack Rusin <zack.rusin@broadco=
m.com>
napsal:

> On Tue, Oct 27, 2026 at 5:32=E2=80=AFAM Tomas M <tomas@slax.org> wrote:
> >
> > Hi,
> >
> > I found a cursor hotspot regression in vmwgfx while testing Slax
> > with Linux 7.2.9.
> >
> > Environment:
> > - VirtualBox 7.1.10, VMSVGA, 3D acceleration disabled
> > - Debian 13 userspace
> > - xserver-xorg-core 21.1.16
> > - xf86-video-vmware 13.4.0
> > - Hardware cursors enabled through normal driver autodetection
> >
> > Resize cursors appear displaced from the pointer position. For
> > example, a horizontal resize cursor with hotspot (13, 6) is drawn
> > 13 pixels to the right and 6 pixels below the expected position.
> >
> > The theme file and XFixesGetCursorImage both report the correct
> > hotspot (13, 6), but VirtualBox's VMSVGA diagnostics report (0, 0).
> >
> > Code inspection points to the GB_ONLY branch introduced by:
> >
> >   eef295a85082 ("drm/vmwgfx: Restore Guest-Backed only cursor plane
> support")
> >
> > In vmw_cursor_plane_atomic_update(), this branch passes only
> > vps->base.hotspot_x/y to vmw_send_define_cursor_cmd().
> >
> > However, xf86-video-vmware supplies the hotspot through
> > DRM_VMW_CURSOR_BYPASS, which stores it in
> > vps->cursor.legacy.hotspot_x/y.
> >
> > The position calculation adds both hotspot components, and the
> > LEGACY and MOB image paths also include both. Only the GB_ONLY
> > image path omits the legacy component.
> >
> > The attached patch uses the same combined hotspot for the GB_ONLY
> > image and its position. It fixes the displacement in our VM.
> > Additional tests with custom cursors, bypassing the cursor theme
> > and window manager, confirmed that hotspots (13,6), (6,13), (9,9)
> > and (7,11) reach the virtual hardware correctly with the fix.
> >
> > For completeness, this setup also encounters the separately
> > reported zero SVGA_REG_CURSOR_MAX_DIMENSION issue:
> >
> >
> https://patchew.org/linux/20260830151619.2452307-1-yunfeng.li.nb@gmail.co=
m/
> >
> > To make hardware cursors visible for these tests, our kernel also
> > has a local workaround that retains a 64px limit specifically for
> > GB_ONLY when that register returns zero. MOB validation is unchanged.
> >
> > Could you review the hotspot fix and consider applying it upstream?
> > I can provide further diagnostics if helpful.
>
> Hi, Tomas.
>
> Thanks for this. I have a series that's addressing those cursor
> issues. I have a better fix for the vmwgfx-legacy-cursor-limit.patch
> issue so I'd skip that one, but do you want to send
> vmwgfx-legacy-cursor-hotspot.patch with your signed-off? I can also
> create a patch in my series with it but I'll need your ok to include
> your signed-off with it.
>
> z
>

--000000000000ff6263065ed7575a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto">Hi,</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Thanks for working on these fixes. Please feel free to incl=
ude vmwgfx-legacy-cursor-hotspot.patch in your series. You have my permissi=
on to add my Signed-off-by, or you can use the patch even without mentionin=
g my name, I dont mind.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
I&#39;m happy to leave the details to you. My main goal is to get the bugs =
fixed.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks again.</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">Tomas M</div><div dir=3D"au=
to"><br></div><div dir=3D"auto"><br></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">Dne =C3=BAt 27. 10. 2026 20:00 u=C5=BEi=
vatel Zack Rusin &lt;<a href=3D"mailto:zack.rusin@broadcom.com" target=3D"_=
blank" rel=3D"noreferrer">zack.rusin@broadcom.com</a>&gt; napsal:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Oct 27, 2026 at 5=
:32=E2=80=AFAM Tomas M &lt;<a href=3D"mailto:tomas@slax.org" rel=3D"norefer=
rer noreferrer" target=3D"_blank">tomas@slax.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; I found a cursor hotspot regression in vmwgfx while testing Slax<br>
&gt; with Linux 7.2.9.<br>
&gt;<br>
&gt; Environment:<br>
&gt; - VirtualBox 7.1.10, VMSVGA, 3D acceleration disabled<br>
&gt; - Debian 13 userspace<br>
&gt; - xserver-xorg-core 21.1.16<br>
&gt; - xf86-video-vmware 13.4.0<br>
&gt; - Hardware cursors enabled through normal driver autodetection<br>
&gt;<br>
&gt; Resize cursors appear displaced from the pointer position. For<br>
&gt; example, a horizontal resize cursor with hotspot (13, 6) is drawn<br>
&gt; 13 pixels to the right and 6 pixels below the expected position.<br>
&gt;<br>
&gt; The theme file and XFixesGetCursorImage both report the correct<br>
&gt; hotspot (13, 6), but VirtualBox&#39;s VMSVGA diagnostics report (0, 0)=
.<br>
&gt;<br>
&gt; Code inspection points to the GB_ONLY branch introduced by:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0eef295a85082 (&quot;drm/vmwgfx: Restore Guest-Backed only =
cursor plane support&quot;)<br>
&gt;<br>
&gt; In vmw_cursor_plane_atomic_update(), this branch passes only<br>
&gt; vps-&gt;base.hotspot_x/y to vmw_send_define_cursor_cmd().<br>
&gt;<br>
&gt; However, xf86-video-vmware supplies the hotspot through<br>
&gt; DRM_VMW_CURSOR_BYPASS, which stores it in<br>
&gt; vps-&gt;cursor.legacy.hotspot_x/y.<br>
&gt;<br>
&gt; The position calculation adds both hotspot components, and the<br>
&gt; LEGACY and MOB image paths also include both. Only the GB_ONLY<br>
&gt; image path omits the legacy component.<br>
&gt;<br>
&gt; The attached patch uses the same combined hotspot for the GB_ONLY<br>
&gt; image and its position. It fixes the displacement in our VM.<br>
&gt; Additional tests with custom cursors, bypassing the cursor theme<br>
&gt; and window manager, confirmed that hotspots (13,6), (6,13), (9,9)<br>
&gt; and (7,11) reach the virtual hardware correctly with the fix.<br>
&gt;<br>
&gt; For completeness, this setup also encounters the separately<br>
&gt; reported zero SVGA_REG_CURSOR_MAX_DIMENSION issue:<br>
&gt;<br>
&gt; <a href=3D"https://patchew.org/linux/20260830151619.2452307-1-yunfeng.=
li.nb@gmail.com/" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank=
">https://patchew.org/linux/20260830151619.2452307-1-yunfeng.li.nb@gmail.co=
m/</a><br>
&gt;<br>
&gt; To make hardware cursors visible for these tests, our kernel also<br>
&gt; has a local workaround that retains a 64px limit specifically for<br>
&gt; GB_ONLY when that register returns zero. MOB validation is unchanged.<=
br>
&gt;<br>
&gt; Could you review the hotspot fix and consider applying it upstream?<br=
>
&gt; I can provide further diagnostics if helpful.<br>
<br>
Hi, Tomas.<br>
<br>
Thanks for this. I have a series that&#39;s addressing those cursor<br>
issues. I have a better fix for the vmwgfx-legacy-cursor-limit.patch<br>
issue so I&#39;d skip that one, but do you want to send<br>
vmwgfx-legacy-cursor-hotspot.patch with your signed-off? I can also<br>
create a patch in my series with it but I&#39;ll need your ok to include<br=
>
your signed-off with it.<br>
<br>
z<br>
</blockquote></div></div>

--000000000000ff6263065ed7575a--
