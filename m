Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3FDFF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 035F310E98C;
	Tue,  5 May 2026 07:12:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=alexanders83@web.de header.b="mh4sTamI";
	dkim-atps=neutral
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Mon, 04 May 2026 17:53:23 UTC
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED3EA10E408;
 Mon,  4 May 2026 17:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1777917202; x=1778522002; i=alexanders83@web.de;
 bh=tNuk23jFxrOu6AO9kELcm5RMAOgEmF6RgwmASJrt5WQ=;
 h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:Content-Type:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=mh4sTamIJvbgPI/NPYOm4Tn4FP9VL3AFc6TD3cPwVkLmXDcY6rKKZ+geCpxNBB6E
 C0Qf8KTkU2kqeNSDGeAxR/gWLCyLAXfS6/pRnA/XaOJse2IuNEUj4MMKo5c4OnCad
 gF/jYDlbooEOjqx1lCr1ZqlGteJMJPK20hTpcfSO/TdywCjFw/QNJMikkxrm5HFsj
 FModxI6X0ubko4ObAHt+F7XVNRZ8owiEXGNKH0AN0vkfG3FtGJLIze2onuQZRSYal
 E+6y3W7MhJrWtYFOZczrkpP8ywoK+rCVynxxyTuEP/SJPRC49IwTVXlmhNN9edEf8
 7v5BUdn1mFZLm41/ng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYcpr-1vpvea0bad-00ULyQ; Mon, 04
 May 2026 19:48:19 +0200
From: Alexander Stein <alexanders83@web.de>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: amdgpu: possible regression since 7.0
Date: Mon, 04 May 2026 19:48:18 +0200
Message-ID: <EPoORLxTThi7O4O6Mpq3ZQ@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Provags-ID: V03:K1:JZO47Eo3sbpNHhQPVVqSpw8NmkhZ+1VUFmhcLBxP4jdjIFqAF3I
 BfTdZcTkh/bbQ56s1Fdn6Rg3yYzG8xgtT19RdrCRaF9SLF9nOJT5hSgemzsF0grQh6jqEN7
 8QG/GD/VVVLR4qkQ3BfKq0i35BbLyW+3zh078YvHj0SoObgnYE6RMKLmvjQQc1JViErWrqW
 gCEpVkPKhrv9ZdkkEbfTA==
UI-OutboundReport: notjunk:1;M01:P0:ZylhTZyllZ4=;4UB59Z3jS1fRfxc6JL8mPeCVk9o
 zxFLWiIYbOAYtYNQIweE12sl3hIvjkRcJCZi1XQcCwmYWQsrvtkOGk5zMqLoE1tNM8d16UkId
 cSZKNnzgwrVzt+fPi2s/gcy4/5/N18JvoPe2x/qrrKWz1XqekiASizglBxSnVkfb7pP6GJXYk
 9/8ApDhQa9QQrhAqEwm36amQby/oITVCV3EYLNYTJtpXGuUyqjhrw6vZCf0VZrwyGgM5X53+V
 13B07gcOup36s2VFTqkj3gtR18g35JbZvWE9ZV+oHWaJka9bBGNCLY+DHLMww+84Ealk2b/5Y
 8VZLjo8g07YXydpwd5MbBcuiGAPP8fJm+vtFsYxz9mlv3z7GHzRWg2ZXzjLaXBr4zlfWQgOFj
 Ev+Xa87zMliO/UVI/P7+fjF5bxLlac5D/XC+BPGMzDSjyfb2d3ZjYcOy5WUtB4zUqmthCCFtB
 GAt+QgFDs/RzRNfk4XQQuRWeKOi9oOfjJJzWbMMUAPMae+uPwSc5qir2BlcBSHRdHFCCpXBjV
 qiJFemrIHBP8g2rNs1p48L+YK8VBYBhPIYUDEVyZ4r4MvlbUBSwg3iROBX962DVHjZvpGBbhS
 xOs99QYY66JQFT/x576Gu+62XOP3Hi1VizmU6h9EYgxuhH7r6k12TvbPdo29d39X2p3PvoqpE
 eJJCCcid6RiTxM3jNeC84PjHoF0IMZUmbCVkGqZ3OvIm7dPIPtd5SJm3uJAnZjZKb0TW3Ct9r
 McsjIFT2nr6PsWzqcTFf+KDVxFmOWluc+jbKQJD2eNuM7YujlUKI11vF1cVFlb79jRJKo4KgO
 lMLHTMgs6q2WYp1LRWKg3KO7IRPj3CfgogZsf7eduDAf7U2HHZSqiWglPNtW+Vj+pwEWrJQ7h
 hwOABUWEBKDNnpMG1KEGu+moi5Qs8SOshdtnl0Xc/7N0xvhG+oG/z/NfKMgefkgSAqcte9sYR
 wzKps2Xs9Uk+BiBHX/hbkBFAxMb4ZOTQqXcd0/RZs7aJqUuUbFhrwlH7PaE6HRZkLC50wvSqm
 bew3LQgdbGtUgT+fHLPvA+b17vCLjU37KGSUQqoOSLfJjU2USHGFgb2qd0mPM3ksxm+Fa1qqb
 yQyIDyMPGjb9dMtj93Wwxex0LbFzgDk++iPyM0OjEc+0A0SVQ/ZmX9sSFCiKsc3A5oS4bNkfX
 WJx0VT3UQxDMdj5qAaT+wZqc/gpdZEHFfFSX2xVDGBiubuBwD80HQSJyRqVOUHLfiC4Xn8VnZ
 P2noR9Iakvw2ZAqLQoCWuay9pR9CoNQZ4u56Qqkr01SEbaX8SqztXHCxWH+1vIVqRBmLuz5g8
 Uj6oaaJCHNEf6Mji+xMNflqgMAG8AWW9TK5qmjZecwRgldRS/6ICj1BX9FcS6xEfk12rU0C1h
 z5K1i+pudBhm4HUJ6G7G0GnKcQ+39OZSNJhtSaEOxC7I7rwW67vDGMpQ/YTK71xdOdP/TaV9g
 DzfGNDJD16jHOFte4Fhqa5NqsVSaRpdrPcn/Bh/oc+yf4Cqa/uKmUaqNB5KLovXNwtZtxu4QF
 uOWnMl+quzF4Sn3dH8MGxJVzomLZjW1s9DT+T/iIO3jzzscm7yxm+lollaWgPVP7qGt8GruA1
 TCxMMBO51WXroUKYYoK4pROCX0uIMP9sYavFhA0e+WOyes8bFiZ5hQCMkc/4IHYC+u2VmufqU
 RXDnnEX+xa9SCjfHwR1Ssuefkm6s4Ci5oAyF+o9hP22e+dK1e5cXUQWq9tYpQiiKEzbWRPThV
 thSNRaHx4omWbA8vyWw4rrL7NPYZw8L1f9NOn+SgxNxz+fHKC/qkaf9am6iVb2VWbwoYaRsap
 /e9ES7GAi3aU7UhH5xjnCXs5IgwVQyRuc/IZHYotNWwda1u1CieJFKIIc4Kpd2wWXzJczC/CC
 vdNSsyrjmtv3APuTrwj4AldRkQfCi4E4KGn6tbtCYvG7U84uPe1GRuzQ+6ZzzRkfCzBTzaSOL
 Fv3emnLwOYQxHhWCj/swrOLY5Az8I0A5oLelVZc+60vtufL/5aoOVbhoLUEkbbpEZ1eSd88Ip
 2SNzXUdofHBDZjHJHcxOwGkQYoNqZ4F8/BE/qwqF7sQfjF0iPygy3xoVhPjia1hB8DG4aSku9
 KOLIJdmNGEIS4h3yzlsDqwUVR6s7iAxvNE88qg9eSKyyuv0FPZXOcdclzsgvd+LEx5gYtpyM7
 7uEVDHZHVY+rQ4Gg0TqZWQJFNk8tURpGaLjv5qOr0hpANiNE80PIfZcb8vhytbSgNuSRH+mjr
 30+XVLA8VFynrfptCjvgKy4MusLk/VjQPBxFBMXBAnIoaoA2p4rUwvdI5Uaa+c/0pgVQy1k65
 w22Uk1zXQDuU1yDc4x02OxwF9w9Sdq0n60A0y2ZoECn6asfOyAG1pP5ocrJKAwxGpjQ7lpJcj
 DQRGrLEgVA7cQdgjuUI+JT0lNjYHCREuro9LHrNAZebt6zyC1FYMeE1viJ1Oia5euC9wyylgz
 yLFRMLE98GOK0O1eHkb0PIyh9osPPPWtjclfebXdL6OuQPJZhbl2mFfquII8ZwgCPuCOGlXYU
 P5swoZO97gREq9NcFznB0MZ4S+JmqK31CsRPo0jSgPT5xa4TZVWipSsu/F4F8cFbgnhhS81mz
 vwqDoyH/9HVudH3SgSM5O0FFYwSJtoDRw8un667vSF9BiZ76xB8UaEfhjpJx9+cZ+Cm3mx7SR
 WDllxOWbHn3o+Hwe0GYNGDTTk0xpe697SH3x/llgncLuXd4UQP3mpIxNTaBS/bxgBuU6ZqbzU
 EjihRoDq5u6c1itMhegEg7qWL06A8FJvtEtmXZAu03a1G2hmRYACWpgCHwVxyPPMSPZa2i4bR
 pZVZTmenM6n35o/FYSQSDlKus68ibwSqNPJ4Oub1laoXDmalPOz7ArT6JaQ4hoAy8xX4LLTza
 5Ol8onw+ZN4rJ/en0PYwmXvgygbSJtYSXfx98RwPW0/KZy9DEtkGYUJ8vTvu97Jvvmj/NZb3s
 2tvqVc3wNj+XkQh92si1ao296StHkwvBZy5JBHnk5Qk/lbZKzsR3fitS1qU6QI8dPl7uFHzqq
 Uqqo0aLbLgKy0VCtzAwdHqslq6t18sfSD2uGmry3vPKhNr/xXjm9AWDGDMsiHY470nk9g9J/y
 3Ddnzo6wf2Y4igyv4/TUi+T3uPnWIBFNWHNtEBsXJtfSiA5L3z6JDZPabCZnRMOhqj2c8rL6M
 YAyRhDBw7m0aZ4Hqw8yPh+fqvvnCF/x7abbuBSbRvPsrsWjylyuWci/bQQTyZnezce9DDKnpQ
 ajTbeREv0DhYKT94FvugsBqE/tWI+6lAny5mZxgSjUdwBKMtb5GuXOgtz/Kvyk65ppaqAfT1a
 A2eIQrKbtIgwwDMr40xNEA9bOV7a/IgHUDhL88odFj3udZxeNeEDe7th9avitS2KzTCJpT8h4
 5MOkHrOUXPQa8TocKyzfQ5TGglrA4iPLXKZd9hBhwUdbeMr8fAh1WzreRl5xRo+MNIqGO4Pw9
 XpCgB4bEKFNazikmLv6TfdoQXEiNNPr+SdwAWSFzIrgMiLJHYAQfE+ViaXTt4o4Eycluep2/+
 QEvzKTNv8zGORGKbF1nBX6oAZYBxNPNqfcZU7Fks8CcYuM8Xy4oB3+1DodsEWXtfLO7LuFGBL
 vl+yVfSVGIxVz3bm5jcgoBo2b+bftkirxLjAiBVzKiRXFshrA27MEyGYQzcRnWwJ1+tHsLxDY
 E1AZNPYFTGKBbtiQIVwTmPDkyL8Ay1zB4jR161iuKw4uV9m4tbNot5s0eHwTUXwmIaoBTJLbD
 DEXlARDXR9iJnwgPwOuQLMHF/jcwuK1AUqsqJ914i+q3FfJ6UcY2sIggI5lNUzL9CGxgu8Hem
 762h/8j4JjqWPbqMWXBOB+oeTlU9CsdA3vaHeK+x80oy4C7WQsL+xrTU5Hwf4SCOT9/0nqy5v
 xdnYWjUVCwYPJop/KJe2Opu7TUpglnX+XhX2v9BSuuqHRu7OvuVDTK+IzSsPmA7vOI6qiMsc5
 5PqSHYQHuwH1darmyTZ70HhIliut9wJFuJNxZf+96rDLgVzl8zhUhVsbAbfDngXalZGNytgl4
 11z21xErpGfK6CjDYDLm34xLCnf6UgVlOFSe/ZL6/TBrdztZZPI+N9XUB+/k3snpKhdsLyASu
 4FZp3YEsOKAumbVITEWhiXPuxxnkyBkpQ/QdWQzlB5twCNxHXMH79+1Qsw6ncYXSKJ3WuMbBP
 XuxnQz3r4TRqq0dWGancYirpDenCM45VOa+1m76+OhT9GQEwrQl3pUktEC9SH2yxqMzwoPtys
 BeLgsXkyTI9E+T4p2jFZ2tqam6BOKsAT8gxEGEamTHDoaQJpdG9P9+AQeYZqhp3MJuicc8UFr
 Fot004UccduVJ6704Apz9Dc/Ry3NE4gO7xC7m/27BIfWXwOmHwRNDrOSx4dPVTWusXCWsFi9R
 MkyJBfMSKCZKDf71l0Cc+XJBVqZJuUqMdWsn1GAbM5VyGF2Zh2c284HGg1gPMdMwss+ARC7FS
 G3Bf4b1GDCt99kDFdM9/3+BW9Kdrl6M0QQpAVInunC7aI8VvRHa7BGIcNn+toJQN0H4qaVpgh
 avWSDvI5pK9xUDa8t9NPn7tM42Igufa3RJ5Htbl3z3cKmVJn/iWQ+vglN7unfvAi/oYiS/5f7
 URVnGq8ykNhWI5bjpkqboDKCjPO7hDfGeqCImHcusm7U+3W1irOjbAAmmjlfAY8XKdeuTfpcl
 h/ZF+4VmQK7G6oGctJ5cYp0CEuQuZIzujqucl/QhKHTtqhhqG8A4AXVvzGEqZXyuQ+Sk9AcGi
 ShxT42UjP2PD6/3Cp9kCl0kTE889aXTARY6OXlLNZKHblTOQdSMXH8jciAAgFn4lh3nNMwnJM
 PEC4Njy9OZ4rxMY1lehLUZcrI2AIGgG9OKmUAjnFyzQEIE/GyH68DznbUdtNUaHyNZNa43e82
 V/Xjxd5v/WMB5iAU85PGNVa6aEgkkR3wOijKJL6+p29lBVF62UQ84rTbnAeo0zcuT/+mR7Zgd
 astCuDOhgfEwq3EiJsCcgLteLBKCm8tlfC88NjoLnsnSlgLkbiconyzdGV6xI+CGKqXyGB5SW
 Unvab7CZuf8yuOkdQMWlSPpS0eg0ssLvM36pbkxbnUFtl91BktyWqFK/0u1J8DYPKFOC4JmOP
 PC9thSznI7sdbzZJ+irdrIYz6C7vsVXXY/w78XREG/LHrZqVU/qI2eweWWvMI2UoEnAw10N9m
 tklNm2mNfxuBngToYNHpPvcnyXYPtDeW+mKI3Hj9mKAKB5pO7zpCKTkKJCe6wO4aj4YFEi/5U
 sHlUERFhgnb+k13cwIbB71hKn0E3wIg061gWBK8qNddqOwX+iBavsGTkY5QxY/OK31qnS9AHY
 ZhdKE5I54iRwqDw41BeOYlBY9qjJkh5K6BW/hp1y3iAQer413Jdn/6dRjdzl+rjZNlwtshJCi
 q9ymz+pS0y6044SLietE8h0dUn5ZtfVYdhIc8rUgLFlBA=
X-Mailman-Approved-At: Tue, 05 May 2026 07:12:26 +0000
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

Hi,

I'm running an Arch 7.0.3 kernel and I'm experiencing various lockups of t=
he
GPU. System still runs and I can shutdown using another VT.
I haven't experienced that on a 6.19.x kernel before.
If you need more information I can try, but it occurs more or less randoml=
y.
Below is the kernel log. My GPU is
03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] =
Navi=20
48 [Radeon RX 9070/9070 XT/9070 GRE] (rev c0)

Best regards,
Alexander

amdgpu 0000:03:00.0: [drm] *ERROR* [CRTC:416:crtc-0] flip_done timed out
amdgpu 0000:03:00.0: [drm] *ERROR* flip_done timed out
amdgpu 0000:03:00.0: [drm] *ERROR* [CRTC:416:crtc-0] commit wait timed out
amdgpu 0000:03:00.0: [drm] *ERROR* flip_done timed out
amdgpu 0000:03:00.0: [drm] *ERROR* [PLANE:413:plane-7] commit wait timed o=
ut
=2D-----------[ cut here ]------------
acrtc->event
WARNING: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9572 =
at=20
amdgpu_dm_atomic_commit_tail+0x38cf/0x3930 [amdgpu], CPU#3: systemd-logind=
/
1063
Modules linked in: cmac nls_utf8 cifs nls_ucs2_utils rdma_cm iw_cm ib_cm=
=20
ib_core cifs_md4 dns_resolver netfs snd_seq_dummy snd_hrtimer snd_seq vfat=
 fat=20
snd_hda_codec_alc882 snd_hda_codec_realtek_lib snd_hda_codec_generic=20
snd_hda_codec_atihdmi snd_hda_codec_hdmi snd_hda_intel btusb mt7921e uvcvi=
deo=20
snd_hda_codec btmtk mt7921_common snd_usb_audio videobuf2_vmalloc btrtl=20
snd_hda_core uvc mt792x_lib btbcm snd_usbmidi_lib videobuf2_memops=20
snd_intel_dspcfg mt76_connac_lib btintel videobuf2_v4l2 snd_ump amd_atl=20
snd_intel_sdw_acpi snd_rawmidi intel_rapl_msr videobuf2_common r8169 mt76=
=20
intel_rapl_common snd_hwdep snd_seq_device bluetooth videodev spd5118 joyd=
ev=20
mousedev realtek snd_pcm mdio_devres mac80211 snd_timer mc libphy eeepc_wm=
i=20
snd asus_wmi mdio_bus libarc4 ghash_clmulni_intel soundcore sp5100_tco=20
aesni_intel platform_profile sparse_keymap wmi_bmof rapl pcspkr i2c_piix4=
=20
gpio_amdpt k10temp i2c_smbus gpio_generic mac_hid cfg80211 rfkill=20
vboxnetflt(OE) vboxnetadp(OE) vboxdrv(OE) kvm_amd ccp kvm dm_mod
 irqbypass i2c_dev crypto_user nfnetlink uas usb_storage amdgpu amdxcp=20
i2c_algo_bit drm_ttm_helper ttm drm_exec drm_panel_backlight_quirks gpu_sc=
hed=20
nvme drm_suballoc_helper drm_buddy nvme_core drm_display_helper nvme_keyri=
ng=20
video nvme_auth cec hkdf wmi
CPU: 3 UID: 0 PID: 1063 Comm: systemd-logind Tainted: G           OE      =
=20
7.0.3-arch1-1 #1 PREEMPT(full)  653fa807272d34162f0f7604ba64e0a2aa402e05
Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
Hardware name: ASUS System Product Name/TUF GAMING B850M-PLUS WIFI, BIOS 1=
644=20
03/10/2026
RIP: 0010:amdgpu_dm_atomic_commit_tail+0x38cf/0x3930 [amdgpu]
Code: 8d 84 24 20 5b 04 00 c6 85 18 fe ff ff 00 48 89 85 20 fe ff ff e9 b0=
 cd ff ff=20
0f 0b 0f 0b e9 9f f7 ff ff 0f 0b e9 f2 cd ff ff <0f> 0b e9 b0 f7 ff ff 48 =
c7 85 18=20
fe ff ff 00 00 00 00 48 c7 85 e8
RSP: 0018:ffffcf07c5537418 EFLAGS: 00010082
RAX: 0000000000000001 RBX: 0000000000000296 RCX: ffff8e36d56c6118
RDX: 0000000000000001 RSI: 0000000000000286 RDI: ffff8e36d7980178
RBP: ffffcf07c5537688 R08: ffffcf07c553730c R09: 0000000000000000
R10: 0000000000000000 R11: ffffcf07c553737c R12: ffff8e36d56c6118
R13: ffff8e3c0f7c7800 R14: 0000000000000000 R15: ffff8e36d56c6000
FS:  00007f77aa5488c0(0000) GS:ffff8e3e69b52000(0000) knlGS:00000000000000=
00
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000024c6052cc000 CR3: 0000000134fe5000 CR4: 0000000000f50ef0
PKRU: 55555554
Call Trace:
 <TASK>
 commit_tail+0xc1/0x150
 drm_atomic_helper_commit+0x13c/0x180
 drm_atomic_commit+0xb1/0xe0
 ? __pfx___drm_printfn_info+0x10/0x10
 drm_client_modeset_commit_atomic+0x1ec/0x230
 drm_client_modeset_commit_locked+0x58/0x160
 ? mod_memcg_lruvec_state+0xc5/0x1f0
 __drm_fb_helper_restore_fbdev_mode_unlocked.part.0+0x27/0x90
 drm_fb_helper_set_par+0x57/0x70
 fb_set_var+0x23c/0x430
 ? update_cfs_rq_load_avg+0x1a/0x240
 ? update_load_avg+0x73/0x210
 ? psi_group_change+0x10c/0x2c0
 ? set_next_entity+0xe7/0x270
 fbcon_blank+0x1f2/0x310
 do_unblank_screen+0xc8/0x1b0
 complete_change_console+0x54/0x120
 vt_ioctl+0xeca/0x1460
 ? security_capable+0x7d/0x1a0
 ? capable+0x32/0x60
 ? kernel_termios_to_user_termios+0x13/0x20
 ? tty_mode_ioctl+0x67a/0x6e0
 tty_ioctl+0xe4/0x980
 ? __seccomp_filter+0x42/0x5a0
 __x64_sys_ioctl+0x97/0xe0
 do_syscall_64+0x12b/0x15f0
 ? __x64_sys_ioctl+0x97/0xe0
 ? do_syscall_64+0x12b/0x15f0
 ? do_syscall_64+0x12b/0x15f0
 ? evdev_ioctl+0x6d/0xa0
 ? __x64_sys_ioctl+0x97/0xe0
 ? do_syscall_64+0x12b/0x15f0
 ? do_syscall_64+0x12b/0x15f0
 ? evdev_ioctl+0x6d/0xa0
 ? __x64_sys_ioctl+0x97/0xe0
 ? do_syscall_64+0x12b/0x15f0
 ? do_syscall_64+0x12b/0x15f0
 ? __x64_sys_close+0x3d/0x80
 ? do_syscall_64+0x12b/0x15f0
 ? __irq_exit_rcu+0x4c/0xf0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f77a9d1604d
Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00=
 48=20
89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff =
ff 77=20
1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
RSP: 002b:00007fffe582da10 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000000001b RCX: 00007f77a9d1604d
RDX: 0000000000000001 RSI: 0000000000005605 RDI: 000000000000001b
RBP: 00007fffe582da60 R08: 00000000ffffffff R09: 00007fffe582da40
R10: 00000000ffffffff R11: 0000000000000246 R12: 000055ae5d6c6e80
R13: 0000000000000006 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
amdgpu 0000:03:00.0: VM memory stats for proc (0) task (0) is non-zero whe=
n=20
fini
amdgpu 0000:03:00.0: VM memory stats for proc Xorg(1111) task Xorg:cs0(110=
6)=20
is non-zero when fini
amdgpu 0000:03:00.0: VM memory stats for proc (0) task (0) is non-zero whe=
n=20
fini
amdgpu 0000:03:00.0: VM memory stats for proc (0) task (0) is non-zero whe=
n=20
fini
amdgpu 0000:03:00.0: VM memory stats for proc (0) task (0) is non-zero whe=
n=20
fini
amdgpu 0000:03:00.0: VM memory stats for proc (0) task (0) is non-zero whe=
n=20
fini
amdgpu 0000:03:00.0: VM memory stats for proc (0) task (0) is non-zero whe=
n=20
fini
=2D-=20
Sorry if this hits the mailinglist twice. I sent it already days ago, but =
it=20
was not visible in the archives.


