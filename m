Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F296FC982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 18:51:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14E0810F066;
	Thu, 17 Sep 2026 18:51:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T3n8vnGk";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3962A10F069
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 18:51:09 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254f9f7db0so189856866b.3
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 11:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789671067; cv=none;
 d=google.com; s=arc-20260327;
 b=U/pnovdO9JTAvCkU3YNjzrhdK6/FPomN84y+hVsz/iMm1Cw5rZ4n2MZRz7t4c2AamI
 kBM08LGxx7iLxFFq/HKrUinmIgJcdGamwOAtYYpu48l8zzgYAtmruD6lBQ9T7vUWjAXN
 SvuCwRiEFl4Rv0tdLn8c4EYFKJNId/nsO6McSW5Dd4oKJ0YSuk1dZ/HrzIQxFkZxL2nB
 gAsQCallxKjDZcGyUs/KgQ+oBwmX0pCDD81Z+f5eGeJ/7cfldNJxfXOjpWJNE69qHKHJ
 yqk8YfHosW0FjhfXbf6HxzV+sBqfYY9WYRO7e/4JjYlyK9XjrBZtx6nH916EVFqpr7dS
 UV4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9kVz82MAvAbBww+/Fr0+me1zCzCm1neo4UwNfXq+b7A=;
 fh=FlYx7hdemyRhtlKAaSQ73rEl1xdvGrwvtO5vrcUucIE=;
 b=dupn+dQk43jnKLOXc3kRUv4DqjTBR2Up8lQBPGJa9DPtfAIAPYUMwnGAV9e7Gjc3im
 STO/BwqezZNSA03WvIV6MheLmVCs509iaFSYiMc3/dknVWZYwnAHOD7kHQm/0+9cNWyB
 cU82cQe5e67ZHHJFTlirIau+MalfUPgOU8K/FmzClranrANRgMbFteQwrLOyRpX671C9
 072OuJg1uNoKZSPYgk7/POTjaNnFmcp7owmsEskVjCHws1NsW7oyggTu/4O4o7vQJ9FR
 b2KQwmdxBO244xHEAcAKkc9rNe3CRhYznaVDzYEHAKV1aoIDF+eFMFypbzdxfDEdkhZ3
 tDcw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789671067; x=1790275867; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9kVz82MAvAbBww+/Fr0+me1zCzCm1neo4UwNfXq+b7A=;
 b=T3n8vnGkciLzjDfHJITqjQfo7Few/yb7PqqlQ40h6DjOBNhJlKSrClL9YwRSzmR6Qt
 AjuPbmtl28QET5+6EM2A7/VYeqdrZmAbEDwtfAxeoZfBzrnjo9bRM4ifYR6uz2iPPGVF
 7lOfHdESiWP88+EXgD7tUvWFsepSjH5lIKCDeWQq6bFtkt00+UkjXUlTbH7WNNXZaV6x
 AIk0Q4STZi4KIbuqQ9y2ER2NTnGqYyTs6x+Lnx4Z3BrR+yWhvlV1+3VMOHBn5cOJ6Wnu
 oQDHce+aYoAS37iZ7dld7YKyNQN3tzD43/TozcjCWn4Q/THbki7CqdeL2lBeGsDZqfmI
 J7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789671067; x=1790275867;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9kVz82MAvAbBww+/Fr0+me1zCzCm1neo4UwNfXq+b7A=;
 b=arq3wnGPSg0El/86Yj3lJCAmIa3Ovxp9aD9NDUbhGcLMI4vkvjVg0AQ93f6Xo0BFN0
 79QN7cj6poWHgM8s7CGy/O5+13j8YCcpz+YtqWwO5zmZHn9Zvk8PQyJlt1WQSFGye8v+
 DDkhNTNGkZ6kisHJDQFIa59Co7d6WmFj+uFJzfVUfok2Z9ypbvcY62WjLDsPfvnjQVUG
 wqlQPSkVMbrjPJRzAwd+JVprBD+rLcMRB1SnQ+QRU5xXnxroZYIaQAS603RSxCMGubUe
 OkTA8cvr3bMJ7u2w8Ez2rzoVQWVEynAT55lztkygFHNamGgUOi7RPw7c7Wt+MlkT4RIx
 S0nw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9AA1q5SVIv7u5gSBztXA4HkPFFJUVToyhw761DGBTgImk7b+/LlkNRZEc9W4uidfXpm2SWrViJtI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kLBt9tGMD38rl1fCw3dbqLuw0BWv5rp0WeW5FV43m+grZGuVQV
 0xBmf6+PHRGkoM63sxRGpt1lYGggSK5Y7W7aPxolkSoICWcdHFco0bPmbTaYHzm2kBS+GzgheOK
 XJKE6lZPORFuavf5VQmxuBGGjfEKzpLk=
X-Gm-Gg: AYBFou1XoLNzACN5pfwSBiriu/P59uyIbIWO0o/rsobwVBK5qzjXJV4aqaMP737rPDR
 UKtF58TyFwHvGVY8gTW2bsri2UQrktl4UhGxGwSyF4aBLhCtTWj2IkSejm5ddO9UyB5quMZty0B
 tQ4/xEW+ddrpnTioSkLg3LhrQSPM5lOcI95PsnnqdVn/tvGyCqLeP4xhhXiiyzfDp8GQqR5sx+N
 PfgZ2F9AnCJb2KnIW+vDhj/HmQk+x0gmQX2iiV8OMxZRBW7jZwhPWWPmoO+GR3hP8DsDzV0zR7r
 1CPjb/1q/WKS96LZhg6GrJX7RxGXHhgS13S7976jWQdsuaYYpIbsYg==
X-Received: by 2002:a17:907:6d06:b0:c29:3a1b:ec8e with SMTP id
 a640c23a62f3a-c2a1569b034mr13494966b.3.1789671067393; Thu, 17 Sep 2026
 11:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260912091805.531666-1-andersen.theo@gmail.com>
 <c7215b173c533cd697d8eb37b56c2a1890ea7c41@intel.com>
In-Reply-To: <c7215b173c533cd697d8eb37b56c2a1890ea7c41@intel.com>
From: Theo Andersen Carton <andersen.theo@gmail.com>
Date: Thu, 17 Sep 2026 20:50:56 +0200
X-Gm-Features: AcwNN1WHuc8o-nFGlfzO4INLAjuamK1x7axEj4QEzHLMTpq90hpTZl6XJiyGKjA
Message-ID: <CANFnrsrR-benwg2i=mGs1RywuwcxkFE9Pzw8O7kGRQnNyit-tw@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/ddi: add DDI A force 4 lanes quirk for Apple
 MacBookPro11, 5
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com, 
 tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

> I'm guessing this is v2 of [1], but I shouldn't have to guess.

You're right, it is effectively v2 of [1] -- same patch, no functional
change. Sorry for not labelling it.

[1] was pasted into a mail client by hand, which hard-wrapped the
"diff --git" lines and turned the leading tabs into spaces. It did reach
the lists, but not as an applicable patch, so I resent it with
git send-email and didn't think of it as a revision. I'll use proper vN
and changelogs from here on.

> Is there a bug report about this? Would be nice to see the logs in the
> failing case. See [2].

There wasn't one -- I went straight to the list. Filed now:

  https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/17087

It has the full failing-case log with drm debug enabled, on an unpatched
i915 with the panel muxed to the iGPU. AUX and EDID are fine, and then the
panel's only mode is pruned:

  [drm:intel_dp_print_rates] sink rates: 162000, 270000
  [drm:update_display_info] [CONNECTOR:93:eDP-1] Assigning EDID-1.4
digital sink color depth as 8 bpc.
  [drm:drm_mode_prune_invalid] Rejected mode: "2880x1800": 60 337750
2880 2928 2960 3040 1800 1803 1809 1852 0x48 0x9 (CLOCK_HIGH)

because intel_ddi_max_lanes() reports a source maximum of 2 for port A.
The matching log with the quirk applied is attached too, where the same
link trains at lane count 4.

> i915_vbt from debugfs would also be interesting.

Attached to the bug as i915_vbt.bin, 6144 bytes -- a $VBT HASWELL block,
BIOS build 1215 dated 12/13/2012, on Apple firmware 427.140.8.0.0. Say the
word if you'd rather have a specific block dumped inline.

> The patch itself looks sane.

Thanks. One thing I got wrong in the commit message, which v3 fixes: I
wrote Broadwell, but the machine is Haswell Crystal Well -- i7-4980HQ,
8086:0d26, $VBT HASWELL, and i915 logs "Found haswell". Apple's ACPI DMAR
OEM string says BDW, which is what misled me. No code change; the quirk
matches on DMI model either way.

I'll send it as v3 rather than v2, to match the numbering you used
above -- neither earlier posting was labelled, and renumbering them now
would just recreate the ambiguity. It has that fix, a Closes: tag for the
bug, and a changelog spelling out what v1 and v2 were.

BR,
Theo
