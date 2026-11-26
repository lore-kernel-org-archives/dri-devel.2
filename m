Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10A1606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 03:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dPkxK9OX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA2A810E2AF;
	Thu, 26 Nov 2026 03:23:31 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2264D10E22A
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 03:23:24 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-3b147e50af1so543241a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 19:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795663404; x=1796268204; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HtWcfzq6QYRKud0neDB6yUmZQgDuRRFbJcQVKQlnPhY=;
 b=dPkxK9OXd0dNtRpXS8edjs84GI8vpWGhpxLd4fiF/y371hQ08Sd87Kv/i7A1ez64Dc
 gfcPWwxaoOPMbmmyBEQOzUwENC9Sx8tnZWz9VZVePCd3wISXzoHIofckvhYwFy30oxzg
 1JAbt7TCBBij2AB9ALOjk2PGB0khV0UMMoE9fMoJbDFaman8WiS2SNV9NeTJ70JELVZQ
 +Xjlo+BU4Anq2kNFDxS/6rVWtVVWb69LmkJN/oVvBUjcZHxwEB3tPw9PuFPpu8EvzoUh
 MlzVVNZoXE5QGy6aIo724ZZA499IYP5RVH+cxleo1XREFvwuEF9wzOnngSuL8NCVBbS5
 llzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795663404; x=1796268204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HtWcfzq6QYRKud0neDB6yUmZQgDuRRFbJcQVKQlnPhY=;
 b=KBX5HT7zQPv1RkUTDNWx+JHFqD1W1XEalX5JBU1hLiO+3CGRLgh7qgGRXsWEJhJ0qF
 HwtrcE1o5neebR7ArwbkdMaaZYqZJraPe96EREKFqHocyXOPTMJrOT/nzAmuYwUAhyP7
 81ExmxChh5vHzVAm2yL4t3aRd4rhJ3olM3EpjElDRttICV6wHTAu0+RRO6iDZ2eTA6gJ
 YEKT4JWJB3+Llpn2akygaKn36aFZXA6B4hD2XYfxWYA827UTZM3UZKTHIYw6nxG86H7r
 TidZ7+KvpdLSiZ6ddS7gL4R1x1lo3QX3+fmGX62+LmeXSRoC0X1zMyki9+5t9+kDNwRv
 7Uxg==
X-Forwarded-Encrypted: i=1;
 AL+hErE7P/wQovZ4A/AT6+lTHRD0sU/WiimJA7NiAarbmSy+RUpYAzLJjRw4WkcNM+dCXRtfZSJLfz6v/nU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8RK97ikDB5w54bixNOFm9AaUwU3hvinQIoSx86+FeqlW9m86ox
 B6eRDDzSaDPcXFU3A/sL+FdVHCK8GtHy/GopUvzt2TjwPZ1BNfFw3Jqw
X-Gm-Gg: AZFdTZfI+Z9t5Z2H/zB6RJIQN4sb4thm3tzj2Gl3HUGYuiGc+jTr5HImFrVINLxrqBz
 B8lRlfsjlVACdkxm09W13fSOvSSfQyKHb+G4/ml4xHcUQjnDEuXL085qQl2hJnoRRVAgZNsvlVD
 HrV1NCjMDhg36u8k/q3t35+tJaBCN37AahiNFxQ3A+WLmXF42feWOLVOwp0xHNyFSbbxh45gZk0
 1CgX3Fl40bKBqkvmJyi75XQGtyFYKH07gnil9RJHYNYL7+P8r3jFAtBYu3JaOwgm8o77tRNAm3A
 WfrQ3StzQCpgmSdUzd5s7ZnzNJVhsIwsBiJrEWgxp4GfjIn1pnYefcRj4NwXSP6YTJflEdvllL+
 2MsGzZvOiLa/ub2Jylc2qgERbGeb1nHtA6lrviDqFIEUassNvE9DsrNJANaSn8Olb0xijbPJ4Y/
 5LuMV2hTfUIpnGIqSbocv0bPUJV399fvt1rtmn5HbAliUqkoFnT/OJcMwIeCDa9KnEff8/qSv2j
 nNRyRaVrXz/C1Tf83yHkZEhq1mMbcjjnGKwQEyhcb6Vdnvag054EqPn6RxEf9hyKnNUfb53pM2u
 eKOQCGBiI1JH2FEt7oVT+H+DKr89sBS5
X-Received: by 2002:a17:90a:e705:b0:3b0:9e2c:9b55 with SMTP id
 98e67ed59e1d1-3b41c803ae0mr28913249a91.2.1795663404159; 
 Wed, 25 Nov 2026 19:23:24 -0800 (PST)
Received: from localhost.localdomain ([240e:36d:b08:5b40::a60])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdea2aed207sm3916423a12.11.2026.11.25.19.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 19:23:23 -0800 (PST)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: xiaqinghuan@mail.ustc.edu.cn
Cc: abhinav.kumar@linux.dev, dmitry.baryshkov@oss.qualcomm.com,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 jesszhan0024@gmail.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, lumag@kernel.org,
 marijn.suijten@somainline.org, robin.clark@oss.qualcomm.com,
 sean@poorly.run, Jianfeng Liu <liujianfeng1994@gmail.com>
Subject: Re: [PATCH v2] drm/msm/dsi/phy: program PLL_SYSTEM_MUXES on the first
 PHY enable
Date: Thu, 26 Nov 2026 11:23:15 +0800
Message-ID: <20261126032315.2226704-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117052047.32129-1-xiaqinghuan@mail.ustc.edu.cn>
References: <20261117052047.32129-1-xiaqinghuan@mail.ustc.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Qianhui,

On Tue, 17 Nov 2026 13:20:47 +0800, Qianhui Xu wrote:
>Fixes: cb55f39bf7b1 ("drm/msm/dsi/phy: Fix reading zero as PLL rates when unprepared")
>Signed-off-by: Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>

Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com>

I can confirm this patch fixes DSI panel on my Xiaomi Pad 5 Pro. Thanks
for your work and I'm looking forward to it getting merged.

BTW I wonder if this mail is ignored by the mailing list because from this
link[1], I can see:

-- strict thread matches above, loose matches on Subject: below --
2026-11-17  5:20 [PATCH v2] " Qianhui Xu

And the mail from 11-17 doesn't have a subject.

[1] https://lore.kernel.org/linux-arm-msm/20261116150334.78710-1-xiaqinghuan@mail.ustc.edu.cn/

Best regards,
Jianfeng
