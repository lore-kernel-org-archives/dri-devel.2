Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E792606A326
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ojk+Cy3+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BE8310E20C;
	Thu, 22 Oct 2026 16:02:55 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBACD112792
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 16:02:49 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-35ef6b49813so2664523eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:02:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792684969; cv=none;
 d=google.com; s=arc-20260327;
 b=dqHkVg90mG2sM0PBDEd3r9m4AeFFWMRPuOmD1zzpCg7mZaImxU1w+q7XohAMjt8OaU
 5CMB7mzZwMEnSKCwCLgeI7P/q25CwL4NcXCqeQel0XP36+XNV6OXnLwqgJ07Po2iTntb
 UaguW7McmqZccjampK6RyqPctweJa01SsxTf1x6R/Q2s32ipEEo6Tik0zta2ZYn0JR48
 nrFSGWW8B006DKXr27mAj78t0FfV9tfoeQk2s8MLS47g1VgI9Dk3qIa6+W81VWWFkiOd
 cIBc2X0cs4+mcdU6rtte2eKFBDakkFYG9tLFz1USaR781s0xq48EDRI24Vpnf4zKQCPS
 djYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eA58oXbcrSiAmB1z3oyxKF4Toj+uE3Ix/LWp9TBh2Do=;
 fh=E3gjEKAlBg269vMztXN3hmKrlaU5zqvoAwCOU3Uu9Eo=;
 b=CasQbWLe69t00Q2x2kPb/pnWmZ5qqMROiGQK6cDL+UgkIaAYzUI5GpGtffa2do09HB
 6ZhJ/LjJbIdkshLvuiPQeYsVOzlPnz4dfnuUP3k/zhT7h3cKbPqR1b+I0M+d5ZDjq/GT
 Yb/LNTtEU1RM/75qKueFaDhKZI2hTHv01brk8aTADwxnGgb6PDE8VS0gI03MQH7APPIk
 nyjB7+uPwpeUWnbN/pX+Z7m9djInjfuOTVYEM+9fW2V8S3x3LoXC9tKnfvlrw6pYPhXb
 pGXav5o4krycjIP7iDRCqwfOLt4OGLx2tl5JZZVtLZIN3kb3D/qkXQat6Nvo1VZvVfzw
 zSgg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792684969; x=1793289769;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eA58oXbcrSiAmB1z3oyxKF4Toj+uE3Ix/LWp9TBh2Do=;
 b=ojk+Cy3+H5HKY6XmQZctfh+jHS+kTtaMeEr181h8CVdazcRW5aK3rpdBLUge6qaN69
 ipO7iQS4t1tcMTY9MSG/9hncXPdou6XQ2SCFXTNKY18gltqy9sq9vNhkg8DrFdbw2EyG
 iUnzrlS9qt31EC/PFH2PAKR1lnXTn93VK/NRdEPHwQtuVEAQwYZlGjGNU9JMzHZa3qU/
 KVUs4+RV1tgWt7TLbL+pNTmPK8mgaw443PdE0Y+YDuey0FQVxSMrgByoyNd1vQkYO6Ab
 +Zw/DqvRSkpsIfgfiQwcpA/r05ZVRCl30qQX6zJYh0TuR45GZOrRoaTM4UU9P8GPQtNS
 D2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792684969; x=1793289769;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eA58oXbcrSiAmB1z3oyxKF4Toj+uE3Ix/LWp9TBh2Do=;
 b=okmMPKDot2mNtlkgbtV8RfnToPt0XFq4kccgqRywMma+7KXtIv2aMqxJXrV1Dph70V
 4K7Av+G+C71hswPa1BbBnGEcy3csfDPKKKcYW6JtJhH+tGGk+a8RrlRrwWx3sJsthDPH
 nR8IFdf9JdlJ3wXaOk2GSkvHMgh0qmVM80YbXczsjgwuuG7gneLN13Q6rcQtbnAACbpS
 ndMKSbqLPY8CvvSbCBKC9rTQRRDz51E3yuZNZmTwAUt2LoGbRpNVCkZitckqo6wvNQqW
 Cb3oQyEKeNh9hD9df642yPz3xh6y5MsOUKTV53Ry3Fw6vhInck1IXZDj6d491xtUNtOw
 Ellw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7x7i4Iv231eP5mLMWcl9xbmLJEwTpcslflcrbEcNCcR6flDbSG9CnA3rqLw7Jp4tETYbUHvtIneU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIEL5osy8oAyrLfvnX/Ncvl+pYCWcQgEmM4+DAQTzYt+awPVvTE
 bqDTkDB26rFBWR5DB/PE0AHXE9TVIdExdURHUSIkaMbwpIdfkgjhM0anEr+VzM/tWnxk+czPLND
 SLfqRWON8WoCbUKZKkeJWgZ6kzH0Rpo/Djq1vyPxU
X-Gm-Gg: AYBFou2fq8+Nt0crslN4V38fME88vAra2YlHQLh/VJTFL7aG8ge9prXXBWJPQRmQ+jb
 UgaO1AbGhe0Dlt6h132ith1DQOVianPRZO6xwvX19xwf2iMQdFPsegTEHiGDxFNJocg0XyVc0fk
 TB8NciEAnrfzez94y9+Vfv/w9yDyx4GATsYo/C6hqNzEEnTS/3UEU3F+DWCW8UxGryE9UBGmBP7
 R9cqFY9UGfUkajNeNiCm7JJPEnKsjvOr6JfzQeLGssOdk7HYcWmV241/i8PLgG/JDTu02YOccHt
 vvSurbGlUlCQlX5VRwFTxKAwEsse0KFgndQMrctV6SbRBCfLzZPUQHHMBzTZA43OP7EE9g3iuwD
 n2gaXBGlEy9Csi5HXPN6f8w6Nk9+wR7AGjCs/xbT+XGYFbmF5Sy5HVfProKIKOhSTUA==
X-Received: by 2002:a05:701b:291b:b0:160:6a5b:7edf with SMTP id
 a92af1059eb24-190a728a5a9mr5870744c88.44.1792684967579; Thu, 22 Oct 2026
 09:02:47 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261013205223.2396822-1-arnd@kernel.org>
 <6c18da11310ced4a7c85ac7862c3f5c67b39891a@intel.com>
 <3486e0b1-d188-47a9-9de6-7ee5c2cfd097@app.fastmail.com>
 <90fe0000d611f080164a1fd7f228cd533a2e927d@intel.com>
In-Reply-To: <90fe0000d611f080164a1fd7f228cd533a2e927d@intel.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 22 Oct 2026 18:02:10 +0200
X-Gm-Features: AclHuK8K26Lbju3qBt07ubYqFLozHzTFn-VahHrb67MbQWwOYgc-zANXgi2WEOU
Message-ID: <CAG_fn=WbwZKeaprUu2q640ffLfxOSsGAjGE3CcC8fm7yeJ77AQ@mail.gmail.com>
Subject: Re: [PATCH] drm/edid: reduce update_display_info() stack usage
To: Jani Nikula <jani.nikula@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Chenyu Chen <chen-yu.chen@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 1:37=E2=80=AFPM Jani Nikula <jani.nikula@intel.com>=
 wrote:
>
> On Mon, 19 Oct 2026, "Arnd Bergmann" <arnd@arndb.de> wrote:
> > On Mon, Oct 19, 2026, at 15:28, Jani Nikula wrote:
> >> On Tue, 13 Oct 2026, Arnd Bergmann <arnd@kernel.org> wrote:
> >>> From: Arnd Bergmann <arnd@arndb.de>
> >>>
> >>> The drm_parse_cea_ext() calls into nine individual parser functions
> >>> based on the data format. If all of those get inlined and KASAN_STACK
> >>> is enabled, this can explode the combined stack usage beyond a
> >>> reasonable amount:
> >>>
> >>> drivers/gpu/drm/drm_edid.c: In function 'update_display_info':
> >>> drivers/gpu/drm/drm_edid.c:7040:1: error: the frame size of 1888 byte=
s is larger than 1536 bytes [-Werror=3Dframe-larger-than=3D]
> >>>  7040 | }
> >>>       | ^
> >>>
> >>> Mark all of the individual parser functions as noinline_for_stack
> >>> to avoid this and keep their stack frames separate. This reduces
> >>> the stack usage for update_display_info/drm_parse_cea_ext to
> >>> a more manageable 744 bytes, while each parser only adds at most
> >>> 200 bytes on top.
> >>
> >> Is there really no way to tell the compiler to not do silly things in =
a
> >> more generic way?
> >
> > The problem is really the sanitizers here, which turn off the
> > optimizations that gcc relies on for its normal behavior and
> > which cause additional register pressure for the inserted function
> > calls.
>
> Cc: a bunch of KASAN folks.
>
> I think it's really silly and ugly to have to sprinkle
> noinline_for_stack all over the place in pretty normal code [1]. The
> stack usage for each individual function is fairly small.
>


Together with my LLM friend, I did some digging to see whether this
can be handled on the compiler side instead. Summary of what we found
(x86_64 defconfig + KASAN_STACK,
GCC 15.2 and Clang 21, -fstack-usage on every object):
1. The immediate cause here is that GCC's inliner has no idea what the
   frame will cost under KASAN. Its stack estimate for a callee only
   sums the raw sizes of address-taken locals, so it never includes
   the ASan redzones and never sees the register spills that
   instrumentation causes. For all nine parsers in drm_parse_cea_ext()
   the estimate is literally 0 bytes, which short-circuits the
   -fconserve-stack limits, and since each parser has a single caller,
   -finline-functions-called-once inlines them regardless of size.
2. A generic knob therefore exists: passing
   -fno-inline-functions-called-once under CONFIG_KASAN_STACK with GCC
   brings update_display_info() from 704 to 344 bytes here without
   touching the source (drm_parse_cea_ext stays a separate 368-byte
   frame). Kernel-wide on that config it removes 22 of the 103 frames
   above 1024 bytes and introduces 6 new ones, for +1.2% text.
3. The GCC estimate itself is also fixable (make account_stack_vars()
   add the redzones it is going to allocate anyway, ~30 lines in
   cfgexpand.cc). That reduces total KASAN stack usage by ~7% for
   +0.35% text and fixes this particular case on its own (704 -> 368),
   so it is probably worth upstreaming. But it is a correctness fix, not a
   cure: it doesn't change the number of frames above 1024/2048 at all.
4. The reason is that the big frames under KASAN are overwhelmingly
   functions that already have 0.5-1.5KB of genuine locals without
   KASAN (97 of the 103 above 1024 bytes); KASAN then multiplies them
   by 1.5x (median) to 2.3x (p90) through redzones and spills. No
   inlining heuristic can undo that, and this is inherent in how the
   stack instrumentation works. So for KASAN_STACK builds we think
   FRAME_WARN simply has to be higher than for regular builds. For
   what it's worth, Clang does worse on the same config
   (149 frames above 1024 vs. 103 for GCC, 1176 bytes for
   update_display_info), which is why KASAN_STACK is already off by
   default there.

Arnd, one thing I could not do is reproduce the 1888 bytes: with
linux-next's drm_edid.c the worst we get is 704 on x86_64, 752 on
arm64 and 1264 on arm64 with PROFILE_ALL_BRANCHES. Could you share
the .config and GCC version?
