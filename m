Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC50C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECB0310E689;
	Mon, 10 Aug 2026 06:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jdxVIdbW";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2608710E32A
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 20:56:15 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47f59f25ec4so1627069f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 13:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786136173; x=1786740973; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k+97syVWqVx1hhBOA8cAB/VJ6eKbIprJ1K75ZSk567U=;
 b=jdxVIdbWZeytSDogjJ4nxjC8YOPSnLomjsqbGQapfv9Kq1t73A7tZai3kW+yluHER4
 d86zvsAWKdctNkCEL4xGuM03+12y5+1s/68zT5C7+Cobshm6WgR5lzs3Pmyj5OyavSut
 J307UKcYrxo+/muRO6hctP7OgvlkTjcXaRSMrdLjcxjV2mw//QLgXxLeboRD0RuXi4sN
 e4vZMNkqP/gJYciaBp5ogacKdCYDtxtjxKlMExwrImMzmkwS3VyQL7bFMH1iJQ8T8MJB
 GYdQCn7rYlWj2qTBxkJSb8wJwv+g3FeR7FX0CvDtdfSPzgmQh0Y67Y7FSIXkGCAaazMO
 wEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786136173; x=1786740973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=k+97syVWqVx1hhBOA8cAB/VJ6eKbIprJ1K75ZSk567U=;
 b=embVgCiQmFL1c4RPc2TyXbusNsngnHQoiqy/79yYvA18HVsuX1GrLR3pB/bQWYQfx7
 8r3nFoE7WyDy1Ch+ElIHIbrLb/kMP4PTPCs3pCbagPh7tXIizkqsTAedo2kqUcYU+loB
 KIT8/T2zf5WN0/cuDybwJ29XgjYxq74dHShwpAIp+SXAWKqcloZ3GraOl1rM6kD7vXtq
 I4yPlE1Knj2niOUF/pMewTSfkvJ2ovnMF/arJmgYJsnFQVpBf9IbznxNnu9ctSU7FpIg
 YpyYghZ+qu0g7u4AopVysDd06TyOBhQGWRqcxHKazj0EHnE7K4abPc6z2FQTeT9A34An
 QDiA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rre68ToJY6vKLKtJKJnPuaHxkoyrz1QjIpA30L2Hll64WffQDJ+fQO6oCBVFrrejc3UgW3w6xxx6nI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/IsiNB/I6rQ6WtXogyd8REAeIg98ve5cu+2xms4lX5FCsv/ZE
 /Ni6FSBjW+c79+tb8kZWX09uh3+tQbnuWQTvnHNjaiqULvdFvHwx9rFS
X-Gm-Gg: AR+sD128DzagMeg1Nr1/Cx6qzve5WRtdrqWu8udfIlJO7IHllAClLpS+4W/IbaQ8YTB
 WxMOspb6To2uQP9Qry+bbHHuvzOq39l3gJ1AZmtJ1hqrrp96JEmvXhDoyX0aWKBa1GSlHuaAA+q
 JFzTqux2yXCQ/i5v3j7+IIIbiknu7rK+zTjPx75L7YJerd4RcLM8hqBdrw6GyhtWG0kVMDI5pm2
 z6MpqoAnpyA6XF5pKVKZYbiQwhBcPZ/QjX4zzvKPn93m+6hoM6FXNFZ6MGuH3SFzfM01Ek+HDnL
 lbJkxaahJylz6j4MnHOvqEP+MQDw3ZG6MSG6DfMl+uS+8CxhjXB5VKVUYCIZMNTPdpmy0XEGS1c
 sen1grV6QE549rAkKSAA+68UjqFLL+FMVZkXfUnK2LDwhuq+xCQQaymkprFvE6s9+rkOAXwOJmp
 I2dZYRwp5msxYs7u7hHII8LALYftdhHpm3p5xwRbALo3J9d+2/v4Bo6Nh5lwQK28xzbbfVl4F11
 8GxOo12ZA==
X-Received: by 2002:a05:6000:29cc:b0:47f:9266:9bde with SMTP id
 ffacd0b85a97d-47ffd203edcmr15201425f8f.4.1786136173273; 
 Fri, 07 Aug 2026 13:56:13 -0700 (PDT)
Received: from christian-ThinkPad-T470..
 ([2a03:4460:170d:5700:848a:c270:b637:504d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021501bcsm8897658f8f.9.2026.08.07.13.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 13:56:12 -0700 (PDT)
From: =?UTF-8?q?Christian=20Melendez=20Nu=C3=B1ez?= <chrismelnu@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net,
 skhan@linuxfoundation.org
Subject: Re: [PATCH] PCI: vgaarb: Remove stale "not implemented" notes from
 docs
Date: Fri,  7 Aug 2026 22:56:00 +0200
Message-Id: <20260807205600.198878-1-chrismelnu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807200639.172487-1-chrismelnu@gmail.com>
References: <20260807200639.172487-1-chrismelnu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

> [Severity: Medium]
> Is the "unlock all" command fully implemented and working as expected?
>
> If the user holds only one type of lock, wouldn't this fail with -EINVAL
> instead of unlocking the resources? Should the TODO disclaimer remain
> until this logic is fixed?

This is correct.  "unlock all" sets both VGA_RSRC_LEGACY_IO and
VGA_RSRC_LEGACY_MEM unconditionally:

    if (strncmp(curr_pos, "all", 3) == 0)
        io_state = VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM;

but "lock" allows acquiring them independently via vga_str_to_iostate(),
so a caller holding only one of them hits

    if (io_state & VGA_RSRC_LEGACY_MEM && uc->mem_cnt == 0) {
        ret_val = -EINVAL;
        goto done;
    }

and returns -EINVAL without releasing the lock it does hold. So "release
all locks on target held by this user" is not accurate unless both are
held, and the caveat should stay.

I'll wait for further review before sending a v2.

Thanks,
Christian
