Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4D5606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OKPukWGf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2850B10F311;
	Tue, 20 Oct 2026 07:36:51 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF00C10E105
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 19:26:45 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-35cd4e8bdbdso3596361eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 12:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792351605; x=1792956405; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=abSNPbr4DYdK0qk4yDwxN88lTWnE55zJDXdIxaDoNCE=;
 b=OKPukWGfW0+9rNBnUZw5OCQ36AEwjo+ssn9SoMAnHxxH42qvS1k4vrt+WkCT7svTRL
 IwvIAv41VsHViQN+xiMV8GZQlkfe/ieAdTfUVl1lORsSiOFySJn7EiNmtQwBRZwa2Qgx
 8u+L5CuRcT7JZLa/ma9E76uor9gtez1X4eawFqLBQGzHELrW/WSwO+xsqJtt4Uv00HaE
 1K7bslVZBD9jKetVPPLrwulSNQJVt/19t6gj0csc2V6GQCaz0s13bjhq3fzDuWo0IJE8
 W6uBRKKtZN0HSPDiK2lVHSEYbwzYcGVjvON8oTAFg7fO1/v1KUf7z7PF5rU8XxeyOpwf
 BKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792351605; x=1792956405;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=abSNPbr4DYdK0qk4yDwxN88lTWnE55zJDXdIxaDoNCE=;
 b=M9P07GZstj7FpxUsUUj2HT/7Ky5guTswSN5txt7dOgfw+xIXS7EQhHppo5AAXM41LZ
 lJiNOe6Ea/o7BOkdfnwKtdCyONHah8fXICgAvU+WRXULSN2qqdAPfYlnFNfXIYvy17UW
 CWzf3yCwWDL2m7B5RKC9KbKm6ATiU9wehnhXYo1eBTkS1iBwdWt+fDQhNa9bM+ATl/Ud
 uqbUBm7BF2Lm9dyQulk/zSAMZcwBtebAnJKDLhWIi6OhxDYdt8n5Ux/kQHzzS6sqFtra
 EFaOGMifKx7jyJ2YdtH+POxche2BMs5bj0heJrEx+jsWIgnmgJeYMK+2awyJK8ek/RNe
 9SZw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIcRIqgwvPh7pIwHBMp8t9fE09ywxfoCHCTQ+/WpfE0+UYlKpL/I8HKtyCmV6mhKH8PMUflEJ54Uw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLET6atMsadsymPv/KvrV+ImQSbjB/15rD2++TAz9JVOdnRIUfh
 asng5o8FphTZThEx+g/0Rr/wL8JGK/+JxwoUojzZnsB/4OWRI5sfpmTV
X-Gm-Gg: AYBFou1bMZ9F43paJImFv3g4cP9wbduRx0SXo3SI1Jv/NdKYbmafECl8HpFgCU8wXdx
 koFF42mhITntm7hTgG6odZgK13hmuYbepWkJy5Oj0ZkUxwDbHbpWDuuyOcxArPzr6xl5xFXOzda
 e4EUZvgpuuuMGKjQry0XjZA+aGeczTOBTU5KDQBBl8p2GiqkMoTIgq7vbuzDtmCJNIWFZBdB/QR
 BthhTMa9cWDa2GIV0HH4VtnsBZPTKdWEslLgesl/AzMK+ynyXnS9ZXoka1YgkmaqqUnKX8+IVMt
 hQ1kZjHvU1SyGwDY0E84ltR6q0FIHg5jCy40DPEZT9AWwRFrUxRVa7PgawdW/nPHM8C+kEvYliY
 OZqUK9j4X2ft9/tgWc6z0h2qC5IIpc9z8zTmuV1iWgBwQnk9Nt+hw7Hp0zT5majq5ETTwbjNSZW
 P5BE9CO2B1E1w5ELm0R0RKgJ650El0J0cSxwhWtPjCB9YwC+ax00mmoI6+O42hR6YmlpNamN0R5
 5pFKhSIb4IO29KaWqlXqRI2yngEwVYox8EPvCkQf+K2ZfDo9dUemV9lMcIgRrMksg==
X-Received: by 2002:a05:701b:4211:10b0:143:50a0:56be with SMTP id
 a92af1059eb24-185119e3ac5mr9113455c88.14.1792351604945; 
 Sun, 18 Oct 2026 12:26:44 -0700 (PDT)
Received: from lord.bigscale.net ([170.246.211.117])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18319d3b880sm21618945c88.10.2026.10.18.12.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 12:26:43 -0700 (PDT)
From: =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
To: Navon John Lukose <navonjohnlukose@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/xe: Map Wa_22016122933 buffers WC on the CPU side
Date: Sun, 18 Oct 2026 16:16:16 -0300
Message-ID: <20261018192639.97118-1-talesam@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261003222145.67240-1-navonjohnlukose@gmail.com>
References: <20261003222145.67240-1-navonjohnlukose@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 04, 2026 at 03:51:45AM +0530, Navon John Lukose wrote:
> xe implements Wa_22016122933 by mapping the media GT's GuC-shared
> buffers uncached on the CPU side. i915 maps the same buffers WC on the
> CPU and UC on the GPU.

Thanks for catching this, and sorry for the regression.

I reviewed it against 7.2.11. The GGTT PTEs still key their cache mode
off XE_BO_FLAG_NEEDS_UC alone (both encode paths in xe_ggtt.c), so the
GPU side stays XE_CACHE_NONE as the workaround needs. Every user of
xe_guc_bo_wa_flags() picks up FORCE_WC: ADS, CTB, GuC log, SLPC and
engine activity. The only other internal NEEDS_UC user that touches the
GuC, the UM queue BO in xe_guc_ads.c, predates the workaround and is
left alone. CPU reads through WC still bypass the cache, so the stale
G2H reads the workaround is about cannot come back.

Tested on a second ARL-H 7d51 (GuC 70.53.0), on 7.2.11 carrying
63360b32, fc668a6e and d5b0bf3f, with only xe.ko rebuilt with this
patch.

Probe, dmesg "GT0: Using GuC firmware" to "Initialized xe":
  d5b0bf3f only:   3.56, 3.49, 3.52 s
  with this patch: 0.37 s

Resume from s2idle, wake ("ACPI: EC: interrupt unblocked") to
"PM: suspend exit":
  d5b0bf3f only:   2.43, 2.92, 2.97, 2.58, 2.93 s
                   (xe done after 2.28-2.83 s)
  with this patch: 0.39 s (37 s asleep), 0.40 s (386 s asleep)
                   (xe done after 0.11 s both times)

20 minutes of VA-API decode, two decoders in parallel on 4K 10-bit HEVC
clips (528 decodes): no TLB invalidation timeouts, no late acks, no job
timeouts, no GT resets. I did not disable C-states for that run.

Over the same session I got one media GT "not started" job timeout in a
browser, recovered by a GT reset. It is the same thing I already see
without this patch (four devcoredumps since October 7 on the UC
version, all with the LRC tail in memory still equal to the head), so
it looks unrelated to this patch. I have reported it separately in
https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678.

Reviewed-by: Tales A. Mendonça <talesam@gmail.com>
Tested-by: Tales A. Mendonça <talesam@gmail.com>

Thanks,
Tales
