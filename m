Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BF2606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XTwPP7Lg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3AC910EBAD;
	Mon,  2 Nov 2026 08:03:58 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A42010EAE3
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:45:08 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso1805075eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 15:45:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793576707; cv=none;
 d=google.com; s=arc-20260327;
 b=dBMEYqVKpqNDzkjttQVzB8hMp8EMDhACCyMDZI27gg0gEdMgIUP830xaWuJooTSHU5
 N1ERqgAFx5Ulhfo1LLsyMK4xjtQTykL59i0IRAFVaVHqFGmCJ9X7LAwKsuq7b03u4xvZ
 stNofAPzUxobTI8+q8lH+cabvXfF3Lb+KhDLp5dkfJufmI7sdgN29KILbt4733yelCvb
 95yvpwmfvrpGQlE1a1irtVHfCLTemgZsEmQrnZmyIv7UM67HVV+dWnCbZPtQ0qSozpsO
 nc0uBNDNPFixuyBGXXUBGcFZgnNJ0qFmlm5/KnG8Ku27SZKb3P6dNctj2MkLLCy1yUhy
 Wv4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=uvWXzZnN9JjIx8rv+D4zcNjMU0NQ3JuADtUsGSRWlcU=;
 fh=p9BrjKFrcEUfUiBeeVMKJKvVwE+8GkFaTNJ+d+LrqPg=;
 b=P/TG2mE8dP0pXrpgQwSknoysvfHlBEGDJ0DhvOf9LA8W5vYnpmggF2QWlKiCtPHnQi
 jnDct2TKUZUQ+bjYVccn8dOlL56+iLoAFq8PQ4MXmKxleK2YtrXdtv969e+IvQQj8pR8
 37d0bB2CYx2Rl+kshV0XS3DdkG/lRkoWmOLAvqtFnfHcOfQS34wSuhO6xgHSx7vQ5HSa
 iCkIXVF7NLBBbcrcUjLLPUdP+c8lwXOC77xxAVzAXAoOIFJ+oVKHOqv0XXd1W8mFshfA
 lTR0GyXBHP+uSwZRO4u/z6doFqlp1OC57lZQ3U4/okpDoLHn08eunK7V+CPtu6m9FMoM
 2ygA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793576707; x=1794181507; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uvWXzZnN9JjIx8rv+D4zcNjMU0NQ3JuADtUsGSRWlcU=;
 b=XTwPP7LgaCyrm8f7NIg1Y8ixmLviU/1tHfgwrzHijBAnZU2VOPtPqiRWAa1T9xewJZ
 XulTg/ssoDpEpNcEersaIZ429yZKLVO9XJOoCbYIObljt4pg8WpRwi1Yyc3vr+FKbtx1
 2R4vnOFfRw9X9GSlN7d6x6SiGJCnRJk3BpX/jA7cKtH14MFR61VOL91n9RZbuLh0c6/O
 D4K/HTHx5ES+iCwoGvlPEOvgY1bP9snhFYBk2DCgmxLLc2OO9503SsVLxIZLeS9h+qAB
 11hFjZVVKnfcywjKezTPPbxDla0eNQl5gf06xZ0pEmWDEfGJrj3R7qEgsixfqL6UHwN1
 pzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793576707; x=1794181507;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uvWXzZnN9JjIx8rv+D4zcNjMU0NQ3JuADtUsGSRWlcU=;
 b=NePH9OZ42AiGEObFI3iWrRnsA4buLhajrjFZJMPMwpZ/LDdzB+g7SBGOHn6w4va83o
 yN4EqTEH01JZhMgChObUkLWXUR0I6L/Qte2Dtehd2/rLOfxeAqoi5l/rNhOfB4GjanUb
 Rq6OEGoug26XkCBNnFHjETtK0OFYg+YR7eKiwy9C2zaSpcW85BSEhfy26x09YrMLAYBk
 8eOzBpCy1/eVswr/J8PTLh2QWlELAtNjI6Y4Jrfe4l6+WriMGJnRrLO3FY7iOjJtfF2Z
 t6gHfQZr9F2+xPxnM2nn/AtDPky17ZcxqtCAtmppfQL+ryTdYdPvn5Vhvi80K1wIb/TA
 y8Ag==
X-Gm-Message-State: APuU4Z/H0DA4mXc6k7n2y/z3U83A/sA0dywoUmrGh2AeltoWwEI5/rhr
 1Jjwetl47zEI1TIpO+b1O6MtJVuArkJhfPFN+nGybKHB4eseAsN4DWBh6moxpFrNOkw1AtByK8s
 etwUYNZb5MYyoAhvSx9XFrcadEFpMfxLh0rYNqkueKg==
X-Gm-Gg: AYBFou1ekcjecRsb0385T54ZIejVl6zCbvCGvJIGbXw/Nw9zI4FudXlGaeJDvCj95ZS
 imNcm9lbJkYOd+XnEzN53HoPn2MfeB/4xH0ijTGaN1qodftKsbbAbKru6Am00X/gnml9TY+zKId
 VPviOiezmkeiaq5WJpLsThzLGDBahSCjHO3MebP2tKX4oJGbwoHzgHbN4DQ5MME/gF83xVcCIOv
 cksy6xqq10AiMwUMdzXmFwj011lfkzmoT8uIVJezCQ1GOGXuY/ka/UCzy/u+xr14NrY7RX+WTMd
 bDtJeX6j9jzYmePdusuO5Jmc2zxFbkg1G6UpJUX+97Obt+eNo0IW2q+pEwm5JXSORYx22EPnOkA
 ZeOkcW6t3Cgu3qpH3ATkkLY3p3PXG2slC5GIlW8BTe0j2jM1AJXi8XbW87CQKQT0pR/ST
X-Received: by 2002:a05:7300:3b1a:b0:351:52ec:60ee with SMTP id
 5a478bee46e88-36a423f04b7mr20658596eec.28.1793576707027; Sun, 01 Nov 2026
 15:45:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Guilherme Bember Duarte <guilhermebemberduarte@gmail.com>
Date: Sun, 1 Nov 2026 23:44:55 +0000
X-Gm-Features: AclHuK_5wqerX8B07SRJFWVzHbU8VUuDVn3f5B_534xHmuQbLjDbNCYv17ROOSI
Message-ID: <CALykNV4sPj4PPUfx3j9qbc2pPsriNgiUHk2cL1N3+1H_FMc4oQ@mail.gmail.com>
Subject: Is drm_log the intended replacement for fbcon? It needs
 console=drm_log0 and loglevel=7 to show anything (7.3.0, amdgpu)
To: dri-devel@lists.freedesktop.org
Cc: jfalempe@redhat.com, javierm@redhat.com, 
 Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de, simona@ffwll.ch, 
 linux-fbdev@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000007ffa4d065f3f9e16"
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:03:58 +0000
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
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000007ffa4d065f3f9e16
Content-Type: text/plain; charset="UTF-8"

Hi,

I've been trying to run a kernel without fbcon, with drm_log for boot
output and kmscon as the userspace console. Before I go further, I'd like
to ask where this is heading:

1. Is fbcon (and fbdev emulation) planned to be deprecated?
2. If so, is drm_log the intended in-kernel replacement for its boot
output, with the terminal left to userspace?
3. If that's the plan, why does drm_log need so much setup to work? Right
now it doesn't behave like something meant to replace fbcon.

What I found (7.3.0, amdgpu RX 6600, one DP monitor,
CONFIG_FRAMEBUFFER_CONSOLE and DRM_FBDEV_EMULATION off,
CONFIG_DRM_CLIENT_LOG=y and DEFAULT="log"):

- console=tty0 loglevel=7                         -> no video
- console=tty0 console=drm_log0 loglevel=3        -> no video
- console=tty0 console=drm_log0 loglevel=7        -> video, and kmscon
takes over cleanly

Why, as far as I can tell:

- Without console=drm_log0 the console is registered but never enabled
(flags 0x101, no CON_ENABLED; with the argument it is 0x107). tty0 is
already first in the console list and has a tty binding, so
register_console() doesn't enable drm_log by default. I saw this was
discussed in the v9 drm_log thread in Dec 2024. The Kconfig help for
DRM_CLIENT_LOG says nothing about console=, so a user gets a dark screen
and no message.
- Even once enabled, drm_log_init_client() only runs when the first record
passes the console loglevel (it's called from drm_log_write_thread()). With
a normal loglevel the screen stays dark. Needing loglevel=7 to get a
display at all seems like a poor requirement for a boot display, and it is
not documented anywhere I could find.

If drm_log is meant to replace fbcon, at least for boot information before
userspace handoff, I think it should light the display at boot without
extra command line arguments and without depending on the loglevel, for
example by doing the first probe and commit when the client registers, or
on the first hotplug. If it is only meant as a debugging aid, as its DOC
comment says, then a kernel without fbcon has no supported way to get a
boot display, and I'd like to know that too.

Thanks,
Guilherme B.

--0000000000007ffa4d065f3f9e16
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>I&#39;ve been trying to run a kernel without fb=
con, with drm_log for boot output and kmscon as the userspace console. Befo=
re I go further, I&#39;d like to ask where this is heading:<br><br>1. Is fb=
con (and fbdev emulation) planned to be deprecated?<br>2. If so, is drm_log=
 the intended in-kernel replacement for its boot output, with the terminal =
left to userspace?<br>3. If that&#39;s the plan, why does drm_log need so m=
uch setup to work? Right now it doesn&#39;t behave like something meant to =
replace fbcon.<br><br>What I found (7.3.0, amdgpu RX 6600, one DP monitor, =
CONFIG_FRAMEBUFFER_CONSOLE and DRM_FBDEV_EMULATION off, CONFIG_DRM_CLIENT_L=
OG=3Dy and DEFAULT=3D&quot;log&quot;):<br><br>- console=3Dtty0 loglevel=3D7=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 -&gt; no video<br>- console=3Dtty0 console=3Ddrm_log0 loglevel=
=3D3 =C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt; no video<br>- console=3Dtty0 console=
=3Ddrm_log0 loglevel=3D7 =C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt; video, and kmscon=
 takes over cleanly<br><br>Why, as far as I can tell:<br><br>- Without cons=
ole=3Ddrm_log0 the console is registered but never enabled (flags 0x101, no=
 CON_ENABLED; with the argument it is 0x107). tty0 is already first in the =
console list and has a tty binding, so register_console() doesn&#39;t enabl=
e drm_log by default. I saw this was discussed in the v9 drm_log thread in =
Dec 2024. The Kconfig help for DRM_CLIENT_LOG says nothing about console=3D=
, so a user gets a dark screen and no message.<br>- Even once enabled, drm_=
log_init_client() only runs when the first record passes the console loglev=
el (it&#39;s called from drm_log_write_thread()). With a normal loglevel th=
e screen stays dark. Needing loglevel=3D7 to get a display at all seems lik=
e a poor requirement for a boot display, and it is not documented anywhere =
I could find.<br><br>If drm_log is meant to replace fbcon, at least for boo=
t information before userspace handoff, I think it should light the display=
 at boot without extra command line arguments and without depending on the =
loglevel, for example by doing the first probe and commit when the client r=
egisters, or on the first hotplug. If it is only meant as a debugging aid, =
as its DOC comment says, then a kernel without fbcon has no supported way t=
o get a boot display, and I&#39;d like to know that too.<br><br>Thanks,<br>=
Guilherme B.</div>

--0000000000007ffa4d065f3f9e16--
