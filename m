Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B653CD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 07:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF36D10F426;
	Fri, 15 May 2026 07:13:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TMCRaVUP";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9165B10F3E7
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 05:42:38 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-82fbdd60b64so6559990b3a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 22:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778823758; x=1779428558; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0S90v3cSnC5Da6GOQpoJCPTnbSf2YszUbZPGAtd7qaM=;
 b=TMCRaVUPnn3cdu94GMr6T2zJlFk0moGFA//MMr9oOhkCzwPZCWFIk2gaHzuchOE9EM
 mAiOO4WUYlhN4Ef+aUpslMH6WzROg/wYe64aRr8EoX9gnsH+3AEZFLE1Owfhsds+qKUn
 Q19vuPQ369SQQNHd0ijvWmpRLrwdMeTmPjEPvzI9TkkgDndt/Oe06QEkvqHpoNz2py5f
 ST1L9N9Mx0r2B8GSW9yt2z2M7IeiquKJDbCUYHaDP4k4CB1ZchSt/VsI7hMpzFnbzah+
 ZSaOWfoxMaBKHU12Q50CteLqj01Zv77xnPHtv4ZoWaDszFlhNgkhLPXe5rum6ArCdN27
 gS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778823758; x=1779428558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0S90v3cSnC5Da6GOQpoJCPTnbSf2YszUbZPGAtd7qaM=;
 b=NSIyy0GhhjHEPIGSyeULaj00mm2yIIjKB1PZywbAVgqv/ZIia7F1ciyj2KMvMyzAbB
 7kX703g13KCZ9TOCoDZ0OkJRO5xY99veHi/fIvRQndWJvSuLlHMVG90verjC9Vo99dzW
 J7s5eRVYn6NZDCzkDrw9kVm39LVStcTRGMgQZL0pDo8XheMgVRnz2ykfIXZjQHPoz2IA
 f9SHnl614Ro2SXnk+VY4xWhDfBavn3h2BozZGEkY+3Tsctaef8jsV62OC/UMZE111VNa
 mCbWKnsYdiZPpAH2rgGnKOxUjyUgYtf0G7pJJ9sCE5nZay52FRnYj6o2RW0xpNHQ8kiE
 9ApA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/6T5XSvKRJHF20OP+b7Z20vt6InY7rJYJIdWzd3I0d+rerGtXJGUdmqbhyLZ5PzuLrawd25pQR7g4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+UvN7CHzoffyAw93pTwcQQXyI5iitaW/wv1Kff8C+8TT1fQ6l
 e6/xTETEM3UECUSXrRm//im19VMFeQ44AEV7OmtM8pMt4hkF17SGJvie
X-Gm-Gg: Acq92OEdLLo3F6DX7NQ5Z37PBx7ztt8uS//xY3uEj2AURXKZo0Vy6SYeluIK+KAnkHD
 oSziyi3uo5K12wx6sy4+ib7CiFvXLqET72QYHcMRH9WKRWZRLQfuVvWGlThYdFtOfiGUq/YJEu0
 YhGXJ6rLq104yerrjIGR3GiC8tS1W18lefKXG8X6+YSi/6LhBPgyPhlKG7Dh6WgooHC6wcJOEeN
 XZP4uZfZKqGL3kXwmHESi34Egk06WYIaRs3sP1pmZDmWdACOVVxwboLL/76kEDjABP8p7xZ6SNA
 CtVr3wFuQyGonGAZJhTr5G+nlm+0lCz5ed3rXUmzQPezpK5uDpVAXhmbf+xbDIyX37wCL5FlGvA
 lbEUMyBMQ6RAdMAjiUQg6lzupBnWl8VNGfv3EgRzhMQYGpuhBgE1sV8W3JxeHs+16derroFGRVX
 YJQAZovlpTcvXjGzC/dyvGx45EK6/UwUp2DJaHZ4/1knpymJAx44KrXLyEDMqKzbi3qTX1boPAF
 ryDTiomQv0/IGhcYPwQXdmjOCw=
X-Received: by 2002:a05:6a00:400a:b0:835:cc47:6fe7 with SMTP id
 d2e1a72fcca58-83f33d96b70mr2736897b3a.30.1778823758064; 
 Thu, 14 May 2026 22:42:38 -0700 (PDT)
Received: from harrison-Surface-Pro-12in-1st-Ed-with-Snapdragon.wework.com
 ([203.117.161.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f2b9bec8fsm3106116b3a.33.2026.05.14.22.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 22:42:37 -0700 (PDT)
From: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, jikos@kernel.org, bentiss@kernel.org,
 luzmaximilian@gmail.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com
Cc: Douglas Anderson <dianders@chromium.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 2/7] dt-bindings: crypto: Add x1e80100 inline crypto
Date: Fri, 15 May 2026 15:41:47 +1000
Message-ID: <14cd42e3d3af4b2591c9dd8dffde11ef18666751.1778822464.git.harrison.vanderbyl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778822464.git.harrison.vanderbyl@gmail.com>
References: <cover.1778822464.git.harrison.vanderbyl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 15 May 2026 07:13:06 +0000
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

Add compatibility string for the x1e80100/x1p42100
inline crypto engine.

Signed-off-by: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
---
 .../devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
index 876bf90ed96e..a338c4a33e98 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,sm8550-inline-crypto-engine
           - qcom,sm8650-inline-crypto-engine
           - qcom,sm8750-inline-crypto-engine
+          - qcom,x1e80100-inline-crypto-engine
       - const: qcom,inline-crypto-engine
 
   reg:
-- 
2.53.0

