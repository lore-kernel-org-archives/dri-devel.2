Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D295CCF2CF
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BDF410E6A6;
	Sun, 18 Oct 2026 14:54:37 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2494A10E314
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 12:50:42 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cc4dbda1e5dso2605236a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 05:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792155042; x=1792759842; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jYaPrGF/xWgZWIb28wo3Id5jgjP9ot6JfkJvYOmQhXM=;
 b=Fpd+73wb11z62fLqlUkqiymNuhvmOj5rsRzdtGnviLCpWbvm86PQSYYM59Q6jzX1o4
 5fy8t86Sg8qsiOq7gHb/+NfS+p1LNsNrhJ4Ny/Xiy1q7bOd0xwBayqr8XGV9In5tpx7M
 P3xbwTqJ6sOLOA3prh/t5+Yo7et1qU5A5LO1kkkZgniV9fOGUbfKXmqojLwFTzeiRbIf
 l4FSFDyl3+352M+0HdRJLJP+GlWzpkIuHdg+GWUqRznL3EKDq1M+I8vnF0hcTDkwYwJE
 tpjabjaKVyerJnpU+VeBo92JLwoKr5EUpS7m1ffc7WO0aM3yDAF+npsfvWlxN8UTderf
 S74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792155042; x=1792759842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jYaPrGF/xWgZWIb28wo3Id5jgjP9ot6JfkJvYOmQhXM=;
 b=VyKUlg0FZJP73zxIuwyzVFvFoxUNGStwFoSlKb73E35ejJIsgdFi3T3v9ISTgm8YGx
 2VgyppkriblXfVLtF24WW2ABssNgwDcv2erjo/zEnr7TefXxYPUfkVJKXk/ZYjWQ0NIY
 cM69mp5McfeDAasBtmg2Us6d6GZcfKLMUqcIF+I8j2M1QivXvNoRa/C1C+GpbmTgRxJP
 vpe8y9/3pHhROfKiXLtyzZ/T2PQubV396SIXeGu09QN/pUsRQQSEdIsRtz4T2PQCpCCk
 3B4SnMLVnb4gWl8Puj3IvFP4VvaLPa7GqI28pR7EglJS8NByrSE9soRlO2y7BcWFp8CZ
 yWTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYQjTONBrvKeixBaSFHOsHXrOmboURWQ6qz0wK8upMohFFP1O0GNTTcGb+3YrBoxs/CPpM7jOERFc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLs+yhyjm93DV0fnCs7IHfLkfJcQualZgxyNtj8wubHOyHfMDBF
 MXi8kl4ZPEuZCe56xeC4+f80cyI8qlCgz/2O8P2CCthVigCsOzbziwjF
X-Gm-Gg: AYBFou2GJWGWyJDR2XLglwrqdaVYzKQ3Nk4X3JmtS2jEJ5eRV18KRrwQeH5iGGvfGBC
 hFmXQ2OqyVCyKeoBFVO3TVS4JUa641RSYgNUEfHYWcQUPdNnYztgfzNuWS6qiptrqYjvZpeGqbx
 fWOh7JK81uHrSokzS97UAO1qY270BT2WFYzidag+J6bpCuICxhTqMGv2KqjaQ/74+aZvHoeDD3B
 Dh9sZAoHJ1GQ10GMd8Mpg4zNMd0isYgTgAtNCwNcqfUYK55t0NY6ASEH68UANPZ3/RzcBRKeik/
 g7+4j89nE6PzmpquMTjnBNnw0uqVUIhiwULSAW2XOD5Zkz8O4el8J7QtSl9vBunIb8vW3Cz0h/F
 Xl/Xu3TXH4NKbNal+3F9CPUFH8SjE7eqK+KgHtEdM9SCLww4gNOGFA3/wozkAwmnK+mpf7fuKCR
 +OK7dqYOS5ZR+hOIro/m2Q5VBRRnUybphjObqo5aNi1T6ElNvOwKcuF+n8gIsLUWu/7nLGQMnKR
 W/lRfddr9Em4Q==
X-Received: by 2002:a17:90b:5444:b0:39e:6a7e:ee18 with SMTP id
 98e67ed59e1d1-3ab3ad26901mr16645330a91.36.1792155041547; 
 Fri, 16 Oct 2026 05:50:41 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac94792925sm8989152a91.13.2026.10.16.05.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 05:50:40 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: Arpit Saini <arpit.saini@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mahadevan.p@oss.qualcomm.com, rajeevny@qti.qualcomm.com
Subject: Re: [PATCH] drm/msm/dsi: fix AHB clock staying enabled across suspend
Date: Fri, 16 Oct 2026 21:50:35 +0900
Message-ID: <20261016125036.1069-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261006-dsi-ahb-clk-suspend-fix-v1-1-67da848e1b0a@oss.qualcomm.com>
References: <20261006-dsi-ahb-clk-suspend-fix-v1-1-67da848e1b0a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Oct 2026 14:53:13 +0000
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

(Resending with the lists on Cc; my earlier reply only went to Arpit.)

On Tue, Oct 06, 2026 at 06:43:53PM +0530, Arpit Saini wrote:
> pm_clk_suspend()/resume() only call clk_disable()/clk_enable() for the
> AHB ("iface") clock, never clk_unprepare(), so prepare_count never
> reaches 0. The clock (and its source) stays reported as enabled
> through s2idle suspend even though the display stack is fully
> suspended:

I looked at this on a Lenovo Legion Tab Y700 Gen 5 (SM8850, bonded DSI,
v7.3-rc4), comparing the current code, this patch's approach, and
preparing the clock only in the PHY runtime callbacks.

In s2idle with the display on I see no difference: in all three cases
both PHYs are already runtime suspended at system suspend,
disp_cc_mdss_ahb_clk has enable_count 0, and CX collapse during a 100 s
s2idle is the same. Is the clock really enabled during suspend on your
board, or only prepared? Reading clk_summary runtime-resumes the clock
controllers, so it can show a different state.

The difference here is with the display off and the system awake: with
the clock prepared from probe (current code and this patch), dispcc
stays runtime active and MMCX stays on. Preparing it in the runtime
callbacks lets both go off. I have not measured the power difference.

That variant survived 30 DPMS off/on cycles with clk_summary read in a
loop. Did you hit the prepare_lock deadlock, or is it from code
reading?

Thanks,
Joonhoe Kim
