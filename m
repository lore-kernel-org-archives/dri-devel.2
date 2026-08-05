Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85499C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 20:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E412B10E1E6;
	Wed,  5 Aug 2026 20:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="GXNyso84";
	dkim-atps=neutral
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com
 [209.85.210.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF08210E1E6
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 20:48:33 +0000 (UTC)
Received: by mail-pf1-f226.google.com with SMTP id
 d2e1a72fcca58-848479c9bd5so1384881b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 13:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785962913; x=1786567713;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t/Tlp4jv36AXM3dbVTNPW86DHsKltSPiY4ymM/gQVSc=;
 b=BFzVWbgbtFPwMupjUXTML1S9JXim2RI1a5776nd1Mc+a4x0otFmEhX7mazXkKgDfhm
 n0rB+7S4XwpUqx0q+IGPpQj2A2ENv/t8W5vNVlGDXLRuCUn8CTOZoy5C/DgMKHWsamAQ
 /Geu5SRRj1GHUWY3iWqkzhyqyUCYn6jBK7zJwELjFnFZvSN5jDzllyakjmO5TNTAxv1n
 +FlwV9Hw4spd0RuFfI9udHKJnoOzOAs0XWDi7P+h2AtZnP3qEA5XcSG0NJnxtXpgMLBg
 OibyOv7bEbObwb1zNR3F8TUIkYhqS7UvALBpcECXP4iuzt7aA5FYSOfFSflUFgPiqaMI
 0mZA==
X-Gm-Message-State: AOJu0YzYwpno7n9y1ojAVJNL6Z5VkdKQfRQFRG8FbkvXPtueKgh1WVEd
 1URnTyPz2J4UtKweOH6DU4n2kZr9Zf2mnjt9v8viaeG/jMiRM00JqTsxKJ0AjcBhEw7o1hrYKVK
 B6yCHPY/VSQtnea/LK1Zs5ase90U4Ims0L2n2IKT9mKG0Q/qQQClypvwFwefzhiYVNhp751o4Ur
 UT0hhzMzVAOC+K18BXAjrlaGdsHxXX9BcUqzHfkTHEXc2/oh7nBc3mIykCbXCgmIYEfC68+dnFe
 aoLTzRQEz8bltUAwR60
X-Gm-Gg: AR+sD118CamMkoFve9kLxaJdl+1mrUd4gwmg7hBAcQm7YuDxYUpWcq6Z/YKzbC1omkv
 jdr9N11lBNtet5eEBrnZthCZJxpsho/2ju84C3yWfDh0ni5khoVZC4i8/VhGl8evPVrsrsFu71T
 0BgOMPJW0ISSmgKookjBimAWto59MHmm6X43sK2riJ9oWv9FquMwA9fGx2boTiSmMW2e4MrVIeK
 ieOztcmq0mT8jNNBrpuxX6mj0uqYyGn63Wo5WaxwCrdSl1RbDsqcwYz0GCheyt/nQdpecVh2wvF
 26W5I9dQQiCN5Jvmu9ZA16RJRz10qJuWmUhYPmdAdF0wQkzGDW0l1RjNfRNt9hQqsaJws7gXZP6
 g4TSPmT+Y1d3dBwuYy58/oIOc8g9pS+6SnRFejCimf3rxezpGs1Rsk9AkHDGvuXAdAj08fpoGEw
 eZA0uyt9IFDJjZJjBz95avFo9C+xdhVFFJ
X-Received: by 2002:aa7:8884:0:b0:847:9315:fb8b with SMTP id
 d2e1a72fcca58-84f2e031490mr10115079b3a.6.1785962912917; 
 Wed, 05 Aug 2026 13:48:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-cbe706de4f3sm1143649a12.0.2026.08.05.13.48.31
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Aug 2026 13:48:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5aec745104bso810332e87.0
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1785962910; x=1786567710;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=t/Tlp4jv36AXM3dbVTNPW86DHsKltSPiY4ymM/gQVSc=;
 b=GXNyso84q/8pfB3cdNmBXnGZoUVI3q8/nUHlqAopl2ZIv3z3n+XEgj0RwUXij2Ws46
 +QOILbDWKpKmqjNH2a7xiATK5/jvN/9ESXOcxnh0gISXWf3SOdrQqBtscIR4eUH+YJBu
 wV1Go6YqRVs1LWtAPI1HzPuu7/Zlf1lLlLqYk=
X-Received: by 2002:a05:6512:2388:b0:5b2:b7f2:f7e6 with SMTP id
 2adb3069b0e04-5b2f4b8f30emr1373588e87.14.1785962909940; 
 Wed, 05 Aug 2026 13:48:29 -0700 (PDT)
X-Received: by 2002:a05:6512:2388:b0:5b2:b7f2:f7e6 with SMTP id
 2adb3069b0e04-5b2f4b8f30emr1373579e87.14.1785962909345; Wed, 05 Aug 2026
 13:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <9a795e26-53de-41da-bdb8-9ced20b70e87@accessweb.be>
In-Reply-To: <9a795e26-53de-41da-bdb8-9ced20b70e87@accessweb.be>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Wed, 5 Aug 2026 16:48:16 -0400
X-Gm-Features: AUfX_mwhbky-2rcaCh6V0vDmi9Pbpajrw3OQvpQy4TGuNhrfAm_h5omX-GsCUZI
Message-ID: <CABQX2QOEP_g5HvC0Wfn9NZw_88uGjgkp-nJrXzkMXdVFBDh+iw@mail.gmail.com>
Subject: Re: drm/vmwgfx: graphics memory not returned after all GEM objects
 are released
To: "Jellis Onsea | AccessWeb" <jellis@accessweb.be>
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com, 
 Maaz Mombasawala <maaz.mombasawala@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000d9f555065852e45b"
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

--000000000000d9f555065852e45b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 4:41=E2=80=AFPM Jellis Onsea | AccessWeb
<jellis@accessweb.be> wrote:
>
> Hi Zack,
>
> I'm reporting a memory issue in vmwgfx where graphics memory is not
> returned to the system even after every DRM client has released its GEM
> objects. Only a reboot frees it. This comes out of KDE bug 523812, which
> was closed as RESOLVED UPSTREAM with the assessment that this looks like
> a driver-side leak rather than a compositor one.
>
> - Environment:
>
>      Guest:      CachyOS (Arch-based), kernel 7.1.5 and 7.1.6
>      Host:       VMware Workstation on Windows, AMD Ryzen 9 7950X
>      Driver:     vmwgfx 2.21.0.0, VMware SVGA II
>      Renderer:   llvmpipe (LIBGL_ALWAYS_SOFTWARE=3D1, see note below)
>      Compositor: KWin 6.7.3, Plasma Wayland, 3 x 1920x1080 @ 60 Hz
>      RAM:        31 GiB, zram swap
>      3D accel:   disabled in the VM settings
>
> - What happens:
>
> During normal desktop use, buffers of exactly 8355840 bytes accumulate.
> That is 1920 x 1088 x 4 =E2=80=94 one screen-sized 32-bit framebuffer wit=
h the
> height padded to a multiple of 64. Growth is tied to rendering activity,
> not to uptime: an unattended session leaked exactly zero bytes over 7.3
> hours, while active use adds roughly 1.4 GB/hour.
>
> At 9 hours of uptime, kwin_wayland held 1846 GEM objects, 1553 of them
> that exact size. All of them had pin_count =3D 0. At 34.5 hours it was
> 8057 objects.
>
> - The measurement that points at the driver:
>
> I logged out of the Plasma session and logged back in, without
> rebooting. That restarts the compositor (pid 2612 -> 3156650) and closes
> its DRM fd, so the kernel drops all its GEM references.
>
>                                    before logout      after re-login
>      GEM objects, all clients      8139               19
>      system_ttm usage              49.47 GB           45.80 GB
>      GPUActive (/proc/meminfo)     10.86 GB           11.06 GB
>      MemAvailable                  11.06 GB           13.32 GB
>
> So: no DRM client held more than 19 GEM objects in total, yet roughly 11
> GB remained accounted as GPUActive and was not returned. The ~2.3 GB
> gained in MemAvailable is very likely just the browsers and editors from
> the old session exiting, not graphics memory.
>
> A reboot immediately afterwards did return it:
>
>      GPUActive     0.11 GB
>      RAM in use    4.5 GB of 31 GB   (was 18 GB before the reboot)
>
> - Caveats I want to be upfront avout:
>
> - system_ttm reporting 46-49 GB on a machine with 31 GiB of RAM is
> something I cannot explain. My assumption is that TTM accounts pages it
> has evicted to shmem, while GPUActive counts only resident ones. If that
> assumption is wrong, the volume figures need reinterpreting. The object
> counts and the fact that a reboot is required stand either way.
> - Summing the reported sizes of the GEM objects gives ~46 GB, which also
> exceeds physical RAM, so that sum over-counts =E2=80=94 presumably shared=
 or
> multiply-mapped objects. I would trust the counts, not that total.
> - This is a CachyOS kernel, not vanilla. I have not yet reproduced on
> mainline. I am happy to test a vanilla or drm-tip kernel if that would
> help; the machine reproduces this within a working day.
> - LIBGL_ALWAYS_SOFTWARE=3D1 is set here to work around an older, separate
> vmwgfx surface-handle problem that crashed Chromium/Electron compositor
> threads with SIGILL. The behaviour described above occurs with that
> workaround in place.
>
> - Possibly related earlier work:
>
> I am aware of the dumb-buffer leak fixes in vmwgfx from the 6.10 era
> ("drm/vmwgfx: Fix handling of dumb buffers", "drm/vmwgfx: Fix dumb
> buffer leak") and the rework that made GEM handles own the dumb buffer.
> The buffers accumulating here are exactly screen-sized dumb buffers, so
> this may well be in the same area, but on a much newer kernel, so either
> something remains or it is a regression. I did not find an open report
> matching this.
>
> - How to reproduce the measurements:
>
>      # object count and per-client totals (root)
>      grep -c bytes /sys/kernel/debug/dri/0/vmwgfx_gem_info
>      awk '/^ *pid/{p=3D$2" "$4} /bytes/{n[p]++; s[p]+=3D$2} \
>           END{for(k in n) printf "%-26s %6d objects %9.1f MB\n", k,
> n[k], s[k]/1048576}' \
>          /sys/kernel/debug/dri/0/vmwgfx_gem_info | sort -k3 -rn
>
>      # pool usage (root)
>      awk '/usage:/{print $2}' /sys/kernel/debug/dri/0/system_ttm
>
>      # resident graphics memory
>      grep -E 'GPUActive|GPUReclaim' /proc/meminfo
>
> Use the desktop normally for a few hours; a browser window with a
> looping CSS animation makes it measurable within minutes. Opening and
> closing 32 windows produced no growth at all, so it is the continuous
> rendering that drives it.
>
> Happy to run anything specific, apply a debug patch, or test a different
> kernel.

Yea, this is because we never added explicit prime exports
derefs/destroy ioctl's to kernel's drm uapi so all userspace assumes
that prime always operates on gem buffers but that wasn't the case for
vmwgfx so gem closing the resources created from fd handles did
nothing on vmwgfx and every one of them leaked.

Maaz just submitted a fix for that to mesa:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/43386
If you can I'd give that a try.

z

--000000000000d9f555065852e45b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIPOq
9q+e4ZZXQGtLobQNCxIl7aZuTHjY6ylLyxsIqw5LMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDgwNTIwNDgzMFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAEK9re/v7MMcMT6iSw2Pmj52LR5zTlcWjCcnqBp6
MNxvFwoQcdDQT+LIyW4Cp1nLEIolZ5ct7Gt8p/0n/wc7Y1PB9PY5tqQBS6rvsHe6EYeY9St2mK88
Q1h2lsJugzIBlg5iT9EuMErOU+ipS2wjuZuGgzZOjfAOifS/uTErd3wfuH0RfbOsvsxnX2KcCmCU
+Ss7sXeegtEf8TFi5nrDXUMTHXt19U3wVquhtafuGJR6Y2xXVfj7cytx+vkecVzBB6kgzrTuHUrk
R7t0zEwa0OKTW/4uHHLzulngsTXOc0tq5HFVsjk4mJz60pEy4NWwq4niW9mjwaC+tokcWU4tjG4=
--000000000000d9f555065852e45b--
