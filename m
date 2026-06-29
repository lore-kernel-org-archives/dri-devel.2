Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA3CC43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A64C910E067;
	Mon, 29 Jun 2026 11:49:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wupe9eCu";
	dkim-atps=neutral
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9E0E10E067
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 11:49:07 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-7e9bb837fdbso911949a34.3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 04:49:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782733747; cv=none;
 d=google.com; s=arc-20260327;
 b=XbHGUsguxm/1MAImk7o/SJQdxcwPqxb1oS4jvBZ4yo0bW9m8WIDEiR0zDTWZLgTXeB
 pRtIxykbeq8A8OTwjJExkJsTUqui6C+LlbvlWfaQGOkr444BR4SwPYUy0l346RkWLs7x
 ZFpYHZJ42aJWYkajpyN2L9gVdnwlK4hGpRQINhPomtAstEgBxSrWGFIHE9v3yK57i769
 smTBs1BYi8tXr4vbB41PNrEfAGfm1xG0nBShhG4mB5DvMMYMTkH6N5hj8pt00FG2e/0E
 /Cim3Z4HZia5k29++hJa0+YPTvIs7mehbEIo5FiqN65kHaFTQpzJ/y7u/TmMqAlJDxXd
 r8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JxE7eD3ikRpE2wWp2I82PgSkPdwzVDfhYliTblHGFrk=;
 fh=rJbvdBVbBw1hwpfgbWJbnWIlWPMfkABmP06DSj4Tx1s=;
 b=PO1jg7/76Q+o3eQhccXoWQDacBpfQpkRJk+XVca+yOhN96uJ4E42+/79S8OZda94vi
 J+/zNC8sFvufk5+zma4sWwsI9+6NDK1rbYrxWoJyzvqsz8jRk3mwHqRev6/pWGgKc0e1
 Q2uWfg62InLpRrjkJ0js/NxFI6+L8sEGd9lvvIcLIWQ0AQwAmZzUo8BQIVBbs/Gd1cBR
 lfQuzpn8/UzyKjjwRFM4DYyfkUJfdv/sHU+vPm71VQitLAOr4vSWrJp9JqQZSnKyvgmW
 hQ9QiCfwRik+4IlgzhtvNoebKpmDpee9WWX0fqmk0UIDsOM6oNrAu5IFstRLbb25y8W1
 oCBQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782733747; x=1783338547; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JxE7eD3ikRpE2wWp2I82PgSkPdwzVDfhYliTblHGFrk=;
 b=Wupe9eCuqUl6qV41EcFMVhs7ETv1EthrH0EvNB2wOEmjYT7ENSo3W41ZlgeUnu8hTB
 Amjnn3ihHzrWqKuWWzUUQMEN5hMuM7s2tL2IL1WVMTXNU2wozyDJU243jlsb+nFQRQDY
 RtyHUJnGlCWHtbQDk1Ff6OCSxIC1UVoo6va1RM8G52S/PmpYd6ZfoFo4V6UEy67h5Eaf
 ty4UMIpnZD/5qDxj/9GkxdXUUd5yL2Yh7lreumOSzmbtxOhFDwTWyV1BZ7o4NQ+c4iAq
 AbpbPkKImLLY/xt+vnDjrEXamzrc/3O9K48B/MJtZWQT9V6EUXu5d8PGUsDZml2Ysunu
 4fpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782733747; x=1783338547;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JxE7eD3ikRpE2wWp2I82PgSkPdwzVDfhYliTblHGFrk=;
 b=n225aIUzjfzGx3YONIAuwPM0zhx+pFy4B7OKgq3zgDs/idvduxWkZKQ9aofzDWNOFg
 Qt4NbBhIAHsY8K4H5a1hSi7n1i46jMVDG0l399eRkwTI1iTl5r/CaqMuyrpyzk2+59Ag
 SuFmFEsBAfskmBu8M8FS4keaqCUK3wpfZ3afVQxkE+uhy0ayrNGtq0FA03da5eE/FzwB
 890uOYnq3cSOIoJ0FvQuaKA+9VgRcgwAsCoaTwjaV4r1AO+U4kfEd0LNePvF64KqwlLD
 mMQd+ycaoAL1NHtyFa6MLP0jL4J/kBK7wRosALuXJIfqlh+atE7LuIXEhJgr4SDL/DZe
 BVJg==
X-Gm-Message-State: AOJu0YyiBJp7R/w9+U4ORQFPBLZcySiQrcOGw1THbgOcGxeViL7njjSz
 /82Q2rj/lCe9vCZhHvwCW7PZAgqCJzm08odd4uopCXtUjK9fXO+H/pa+MikmBScAXFqYnKStasI
 g7wRnUTNtDrUqDHRgCPMis51ZVmjgogc=
X-Gm-Gg: AfdE7clbkQxnGMV9MmcgeRNCR/cqg+nCs1ep/MAwcLX7oaXDi7Mt3xEwOVSjtgTpn1E
 00iUF+JT+QY4IMQfPRQliYlFj0uwkfOdUzGgNr87YlcijDKWd3aNY5aaB3zjO0UdQvfVw7lzvg9
 XI5s4tjCWAc/TKDa/fdNaMk1PpuLvfEGZoob4sIcnsfN71jPcGAseulcOFTmAYwD/h0W0HPprjk
 HW20IQOemNpDOi3pXealK7z6bELiQC3iOaeJ+150peYOvCGLgXNyRk3HkXQFCmnOAY9fS8k/LY=
X-Received: by 2002:a05:6830:34a7:b0:7e9:b4cf:5999 with SMTP id
 46e09a7af769-7e9b4cf6648mr7985473a34.28.1782733746966; Mon, 29 Jun 2026
 04:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260627105725.9083-1-robert.mader@collabora.com>
 <CABXGCsPHdi3=Tpg2uZhZMuLNmg8r9Bg=OgD39eyMc=pv8gc_TQ@mail.gmail.com>
 <bc41095d-8956-4c3e-8f99-f4bda41f81e7@collabora.com>
In-Reply-To: <bc41095d-8956-4c3e-8f99-f4bda41f81e7@collabora.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 29 Jun 2026 16:48:53 +0500
X-Gm-Features: AVVi8CeZ-ZgM1oz4v30-gpgKgAlVT0WKLg-UDnaJ5KeeLKZnGoq4pdSqA5lHNQ4
Message-ID: <CABXGCsNYEhkprpTh9Pd8Y46520fwNJngS_Bg_QJCQPCf3_qv0g@mail.gmail.com>
Subject: Re: [PATCH v1] udmabuf: Ensure to perform cache synchronisation in
 begin_cpu_udmabuf()
To: Robert Mader <robert.mader@collabora.com>, 
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Jun 29, 2026 at 3:57=E2=80=AFPM Robert Mader <robert.mader@collabor=
a.com> wrote:
>
> Hi Mikhail,
>
> thanks for the quick review! And no worries, I was very happy about your
> patch, which is why I looked deeper into it in the first place.
>
> Given the patch fixes a newly introduced regression (and is very
> simple), do you think there's a chance to still get it into 7.1 - or
> would it need to go via the usual 7.2/7.3 release schedule + backport?

Hi Robert,

The timing depends on Vivek and the drm-misc maintainers, not me,
but here's the situation as I understand it:

The original commit 504e2b4ab97a only landed in 7.2 (it went into
drm-misc-next, not drm-misc-fixes). So 7.1 was never affected by
the regression -- there's nothing to fix there.

For 7.2: since your patch fixes a regression introduced in the same
cycle, it would ideally go through drm-misc-fixes to land in 7.2
before release, avoiding a broken commit in the final tree. That's
the cleanest outcome.

Adding Vivek -- he pushed the original patch and would know whether
drm-misc-fixes is the right route at this point in the cycle.

--=20
Thanks,
Mikhail
