Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B10C5DF8A
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CC0A10E6C9;
	Wed, 19 Aug 2026 06:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FeagN1DO";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D408710E962
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 21:59:10 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-cbeeaac53a9so3909819a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787003950; x=1787608750; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x0L46KhTa9nPWpZYUh2/R/sI5c8j4po8w6gNyYy0NNU=;
 b=FeagN1DO7FcF+xhC+pXGHajDFNUCNHttNrv6si4WTSJgU5B4FbI12SSqohOyiqSXpe
 Wo9Q4R0e0hycGUrHEJ5G34YnphVwVCQVaEDx5ZZItj6uuYerJKHN864Pa/HPEjmHsPwE
 u2o9Vno51gP5AcVMtTdWCLnR6mPU6ZxgJ67YTKSlNWZGdbUlEHW/pYqPy5pV+r6j5QHt
 B3XS8RvN+5IJns4xWZdcpwYhuIU42LlZ28yAXBr0rUxpi9aDLax/4ckbLd4N5ZoTqKIb
 i9pksSF2e+gIG02MQ3VR1VrqoXpZeiMM2yrT/HX9om4zEDNFR/N7/9H2hH4Uv2+MGXSz
 0i5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787003950; x=1787608750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=x0L46KhTa9nPWpZYUh2/R/sI5c8j4po8w6gNyYy0NNU=;
 b=YKXleNoVqtCZsdfpDcJhXCSLnbiFZsVhRb7fAbBSRxB52vwXC+NqebBq2hXPMZG2u6
 H2uvSgbPCECUTE3eQKydw1Yf71CIHCO1A/vHUExPfl+RRlx2eMTu4T8ob+yHSO8CTA9B
 byw736u3SDs3Z62SdrgWe7nZbogQTa6DKQ0eys0oO84rCZ0UJxenltzdwvhODlqXaIym
 ulTvb2M6fmUqxMTl79xE36gfmc0NrifJjVl9TEUJlP7D62t1vhPM+g7OECIHC4atsB9X
 Mc+KKucThMoHN91iXQe+wH28hA9oDLBzLXl/iBot/E6He82AnR2JNfnPrAi3x9fwgDx5
 So1w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoS8s1Id908+bifBEoZdrXNTvJwtIYyebcmqp6/jJB3JKC5zgZNq7LZso7M7W7R/FXTxG+oGbcAYsA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz3U7pkX8ikMjZSEqCzW5DstSCtcpeMlfNQo+qUWCMT7KMHXLys
 tBFrQmi0TUuqD2laxVJsmaj2WNp/MQFR4sOGeAIz5myU1OcLSWYd5hwQ
X-Gm-Gg: AR+sD11L4TYKPHCx2UdTocIi5QdwW4BMMMfEfAcinQHsHd0qdrxT0TEOMxUWWHLoMd2
 DLM74QDOKsHzrf9OMDsVUUtpAATumU6VPWDnxt7OJ3encwuJU3zzuL6QfcqQ2packFYO/AXuitu
 yFvP18hMTJvl7dYgj0DVvsy8EjaEdH1KTynizgB5meuqAshskBEi7cTBT/SqGnzH/eurcJRvWAU
 Ah6hCvx64qyhejiTYtlcOjdwDiZHdBEliOP9UGTMtpbJ19dyHM4ZuXKfHdoj9CYSBwG6aUAttJz
 uxCitimdvvVdOTTKJSSuyZ1vInP6Y+oodi1AzouAn1MJfGp+j2e1fxRIBRchT98dcdzxYW3arKM
 7TyNN8O0pBuQJ39GrFw7/0qyGizw8OcMlXMcmoOLFYK15vIMazu9tStin5+9iJUQzYZ2GRzME5c
 FP8o9GbrSFKXWgHKG3wNZcDw061CZe4RwSsgZLbKXTDenzo9z6nucPq3xrJO3alkNcE0ejuaRzF
 0uD
X-Received: by 2002:a05:6a20:6a21:b0:3b4:61f:1fec with SMTP id
 adf61e73a8af0-3ccda6f2f05mr2853996637.2.1787003950290; 
 Mon, 17 Aug 2026 14:59:10 -0700 (PDT)
Received: from LAPTOP-TD60H193.localdomain ([149.19.17.31])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm10657970eec.28.2026.08.17.14.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 14:59:09 -0700 (PDT)
From: Zhefu Zhang <a723356@gmail.com>
To: Chang Jiong <xspeed1989@gmail.com>,
	intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Ville Syrjala <ville.syrjala@linux.intel.com>,
 Gustavo Sousa <gustavo.sousa@intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH v2] drm/i915/cdclk: Don't force cd2x pipe select on Xe3 in
 bxt_sanitize_cdclk()
Date: Tue, 18 Aug 2026 09:59:00 +1200
Message-ID: <20260817215901.459-1-a723356@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816062344.796615-1-xspeed1989@gmail.com>
References: <20260816062344.796615-1-xspeed1989@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

I hit the same bug independently on a Panther Lake laptop
(Xiaomi Book Pro 14 2026, 8086:b080, Xe3_LPD display 30 stepping B0).

Arch linux 7.1.8 stock reproduces the corruption with two
"CPU pipe A FIFO underrun" errors. With the same change applied on 7.1.8,
the panel is clean and the boot log has no FIFO underrun. Also verified
the same change on current drm-tip (b801f94c49ffdb0f65e37baf31d68570356d4983):
normal panel, no FIFO underrun.

Tested-by: Zhefu Zhang <a723356@gmail.com>
