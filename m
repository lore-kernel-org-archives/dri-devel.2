Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF52C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 19:29:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFDE310F6CB;
	Fri, 11 Sep 2026 19:29:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UQRJ9Pnf";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DCFE10F6CB
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 19:29:20 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b93204449so279405e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 12:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789154959; x=1789759759; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9iZH4smAK/5RQM3yN2gdRK991OBVSlxMLJnV0+zPvsg=;
 b=UQRJ9PnfxuIYnQVuDtEd/fY8um0up3ZKmd8zmPYdBbBSBcfk3qCzoEUUW+JuE9HPia
 QBBtR0z0oQwpQIdX6kw9hiUxJ4lwuVyXaD+I69QdfTI0Rf7WrchUaMNHi1yxNQjAxFjP
 GsPALRKjyxRyyo9/2H1C9jbNBiNPfrD2R6rijYyWrUA1UVv/XHxvy7YzYUmKyc8LBvIS
 ZXA43J1g6GiCV94naJrKo3LJn3Cb6jlvY4VMlyYS/Pnpw517AlFzsXlYQaNMtvaIIyQp
 XLc/eno4YEB/wtxmLFePNzNW722lVAZTapQGdy1SUtdVY4E2upNZZ1ahKVHgHhPo1VSc
 lSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789154959; x=1789759759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9iZH4smAK/5RQM3yN2gdRK991OBVSlxMLJnV0+zPvsg=;
 b=hj1VDUxOVYpeipgOL0iUqrY7WuXtYFYBXDdPFd6RIM8TWoiizd3LvKg956aMh1/5Ez
 yfzQrUHV8xtK2RkwPpJSRm4ifxHhMteomcAUwES7lr+DMKcV4Z/H9ZVKxIGkwJsRMZWr
 e7rw9BFahkxxeAC+fubVI0XA10qJVvz01pi0DfjfaLkdIjfEWJZ3OPTbEfWYRyggmU2J
 AEnrBfS+cNm2sLfNORUgQXJ55FHPYKDdRL/txXaTYG18GykPOCf4XkbWyh08njhuxJHG
 /NnhH9L3Y1afh5HrGrU+G3ph2ECntGGMyFqElDrM4XlboHaegCbJwJ6zsBE0cmS5djTP
 tXFQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwC+nNQFzuaqLvxXDL3lOQT+rzLAXRU+/vjKCIzkyk9ZAENUcAbM90Nf6Ehqw5KPpcsSIvLBBGb8m8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mXMVQrq68DZsiezDrpCJ2/F+SKIs02qk1kCjCi8xOsHN0DDy7C
 aisK0ViJVvL7SE1iyFol538AQjCopDZVu3AjkUOwmlHmnnJbYVRbIC4/
X-Gm-Gg: AYBFou3ECCquO5VCWOJi7yrna9nS9VwKYDoBA7QHdS5pqO8yVM3XNfZlMCjbXrtw/Bi
 bgSiX2mYJDBdmyy8/9vYZTIY0DjrlGk+6U8FK/sPIYIH9elFJlIU1ZyVoNE5AEPYn9x6yp3ReB+
 2LY81EH9D1Df4A5b39nxa7+5HdCu/Rbj7kKK7/Y/rWn6/ndtaxdJMUoFYIq7XlqiZq1ebT3j580
 D8bcvSa/xi/TvHNXkezFiLkR3KP2I0CSJmrrV828ZWKL51yV0/4iu4cfx4F8GA9HpV5awC4xCuw
 BZNEof5w+KQNcf6/3hCkYOZNg+6fOaGH6EIh/QDa0pGdOVqnQnPKYD1MPaiPJEtz0MnjB1pa6vE
 L7DiI+KT4UYRlpxWX6n3p88hiUcI7kCrih2FpbSzIqFpmiZe95bsdoPcQlWb+cI0sHru7H7j5AE
 nt5J/Dm3ggPy+1p3SYsdYcFJA7o8XUAJ0d1KGuyVj0hn9PAe0cII4ox7W4HmGD3bikFRsG1NzlP
 DAruZpbg+ZG15AnwEwXHmB+EzD6RqbasCGvc+bWvMIkNCaEJqNVSz47s1kucKx3KTbf9DAumMCP
 Izs=
X-Received: by 2002:a05:600c:4712:b0:499:d95a:41f with SMTP id
 5b1f17b1804b1-49e61643939mr56344455e9.0.1789154957725; 
 Fri, 11 Sep 2026 12:29:17 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B918F00F78D5B181090144B.dsl.pool.telekom.hu.
 [2001:4c4e:1b91:8f00:f78d:5b18:1090:144b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60ac42b9sm97156775e9.6.2026.09.11.12.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 12:29:17 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Igor Paunovic <royalnet026@gmail.com>
Subject: Re: [PATCH v10 00/13] accel/rocket: RK3576 NPU (RKNN) enablement
Date: Fri, 11 Sep 2026 21:28:32 +0200
Message-ID: <20260911192833.105634-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911122832.1364839-1-gahing@gahingwoo.com>
References: <20260831040804.24111-1-gahing@gahingwoo.com>
 <20260911122832.1364839-1-gahing@gahingwoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Jiaxing,

Thanks for going back over it, but the correction needs one more
turn: both sets of numbers are mine, from two different days.

The 45 (12 + 8 + 12 + 13) is the 19 August A/B square on v8 1-2/12
[1]: no manifestation on either arm, oracle 48/48 throughout. That
is what the patch text describes, and it is right.

The 102 is the 25 August re-run on v9 as posted [2]: v9 arm 12 + 11
resets, all 48/48; differential arm (same base, 1/13 and 2/13
removed) five runs, 8/10/12/8/15; plus 13 + 13 on a third arm with
3/13 added [3]. In one of the five differential runs the inference
issued after the forced autosuspend/resume "succeeded" and returned
all 48 output channels at 0x80 while the CPU reference varied
normally, with nothing in dmesg, lockdep or on the serial console.
That run was on RK3588, on my board, and the v10 cover quoted it as
I wrote it.

So the signature is shared, not carried over. Your explanation of
it (fresh shmem BO zeroed, teflon readback adding 0x80) is the same
mechanism I inferred from the scorer, which flagged 128 as not this
model's zero point, i.e. an output buffer that was never written.
What holds is the caveat I put on it then: one event in 53
differential resets, zero in 49 with the patches, timing-dependent,
and my protocol cannot tell a genuinely hung block from a lost
completion. It bounds; it does not prove. The artifacts (scorer
output, runtime and genpd state, journal, serial log) are preserved
if you or Tomeu want them.

If you respin, both statements can stand next to each other: 45
resets with no manifestation on 19 August, and one silent completion
on the unpatched arm out of 102 resets on 25 August.

[1] https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail.com/
[2] https://lore.kernel.org/all/CAEWPSH5mxTbUkNouxm6yecMZYvDowquhvYvhaXQ8HoMtHD5U1g@mail.gmail.com/
[3] https://lore.kernel.org/all/CAEWPSH5MVzoQMaFOEQ93+1pOPmcXCDNfuXsv5j-X8Lb1fy_hrg@mail.gmail.com/

Regards,
Igor
