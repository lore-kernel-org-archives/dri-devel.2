Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E65C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 19:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56D4810E5D6;
	Thu, 23 Jul 2026 19:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YFLbsvz7";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A572110E5D6
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 19:00:31 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-47f752b3423so670945f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 12:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784833230; x=1785438030; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HPfC1v/GC3kC9s7ibLpR2V6inqtkWGfr1/MYygbgWAs=;
 b=YFLbsvz7FY1Y0HpaxWHtiJXWXep8FkaoswvWLYvK2kttfu92JVqVi1p5Ta4MDColDc
 Ntw27S6J6N9QMKIeGxpxcWdlDnpBFsjsQh4opXNiwIgmLWfareOqd9/4PuRC7b52DHTi
 tSSK6m04cj2CnF3TsxP17qTErw8VPwqyfXgYkSqvmJDOqs4AZNQEWS28SMh9OwBWhEfT
 dTFooFltV1rng5WhhAhaxHzxcOxD/q0XKpFlHZ9W6hU2EnMz0NTCNGmbOveHjs8EP18A
 q58L0kIf3GHfueLDiUtZ5XjBcZUJ+fd6qf4tslvxWSHo7SrrU7U2YhJELWqZ/4ZTjoP1
 zR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784833230; x=1785438030;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HPfC1v/GC3kC9s7ibLpR2V6inqtkWGfr1/MYygbgWAs=;
 b=URLKVB2SxIgIJlsYdl1jFjXnLewOGxeNJMv37uL79sLnNp6p/j6YBOAS7SzqcoLVWO
 XizJH8aHaMLb0hbL4QIkUWvua7QIfDYrFLiINn48enBlm3ui5prh7FgcIeUGWRfWijAj
 G+La0jLkVcH1EoLhqq9BMj3lXb3qQ5+be34QXFYRrnPQAlHPO19hgozukEo1Z+ANhMi3
 z1bDdqELHZpSwvSmpz5/DEiosGvyHBvzXP3U0IhoXwue9IvIL4vaEpTrYYN8RXHArTfs
 g+fFw8s7Z0bw25C99LvddwSN30vtBdtetMP5dY9i90DPdrC4VKYy+XHUFSlPXyf9vKnU
 zfLw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUfbnbbt4jrWB5+ZnhGLbkII+55k2xqIbNTCOMUJutdAmChrh6YHY8gGN3NfmrH+x8pfCS5UW/zRE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz9S2ppxe1XyPIEdHqAt+/SRPmxHumqjhoplG2XGSYI5VAEhsuo
 ITHAiT7FTUiGPgDMe+WB7AbrVQJdk/lNoF8MF96kLaqz5sRdK2gy9/Y=
X-Gm-Gg: AR+sD12iG8QTk+9Wjlj9tbjhOniJVTiOXZkNeBcJZI7duGtONHJFlINdtj6A1/iCbkD
 OoVhauudBk8I2Za4I0GeV98tbsPTd6lm1jmYjB3lNFbn1v0f+sZHB8odqCZnrUtbH51H3XTedJW
 ylHENa5cd8P+v6Xzss7k+MtBK1UybZHjouFxNj/aG76ds6PwS09nB/Ldi5IUGxXnO+Qv//5SDri
 kUFuWRkB8PPV5MOuHSFYIosqN1w7GdY4f3VNhRPZ6PIHUVN+w+QwTBDSr35h7HCeQKeVGqWE9hn
 k1G4reC+YjbchWhB/IasXfo0qXrPYm0VKU21vUuOQxMxd/N6/VSNnsp5oj8+o3/jGKmEvRJRHmu
 YB1MDtNq99CrOL+qY4OSCA6OCuy+GrCDBCvNfSpVDa33hRb5yL8MCxuQQsFCiv7jsVgONRT9LxW
 l1QPdokKoV85dHJwWAEOg=
X-Received: by 2002:a5d:5d0f:0:b0:47f:85d6:9e7f with SMTP id
 ffacd0b85a97d-47f8da5c8f5mr5401418f8f.3.1784833229762; 
 Thu, 23 Jul 2026 12:00:29 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bb5127sm17008552f8f.10.2026.07.23.12.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 12:00:29 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 23 Jul 2026 20:59:25 +0200
Subject: [PATCH] drm/msm: remove objects from evit list after pinning them
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-evict_list_fix-v1-1-1a1d80bf61cf@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyNjXaCa5JL4nMzikvi0zApdw5RES6MkIzMj88REJaCmgqJUoDDYwOh
 YCL+4NCkrNbkEZIpSbS0AEztju3IAAAA=
X-Change-ID: 20260723-evict_list_fix-1da92b2627aa
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Anna Maniscalco <anna.maniscalco2000@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784833228; l=937;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=bx+yq3b6NMB0dC2HA27s9YD6S5hAkMNki5KybhjC2XE=;
 b=Sf0f2MSJU/GLwQvFR0Js5/lGuEXjpQ/cB+5Q5vAvT/u4tsJerowqKCiNzbY+v1LFc8hMeXWyH
 eJl+GGpOgP2DhLd2P54gUt50xzWINULiQgLK8Rh3f8raD6Wgylvd55t
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=
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

Once objects are pinned they should not be kept in the evict list as
that will cause drm_gpuvm_validate to keep ieterating a growing list of
objects needlessly.

Once an object is pinned remove it from the list.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 1a952b171ed7..4422677f095c 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -458,6 +458,8 @@ msm_gem_vm_bo_validate(struct drm_gpuvm_bo *vm_bo, struct drm_exec *exec)
 			return ret;
 	}
 
+	drm_gpuvm_bo_evict(vm_bo, false);
+
 	return 0;
 }
 

---
base-commit: 9a967125427e03c7ebc24d7ad26e9307e8403d4e
change-id: 20260723-evict_list_fix-1da92b2627aa

Best regards,
--  
Anna Maniscalco <anna.maniscalco2000@gmail.com>

