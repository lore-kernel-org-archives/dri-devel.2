Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FE5606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 22:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UWGqe/6H
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 873A710E472;
	Sat, 24 Oct 2026 22:59:02 +0000 (UTC)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com
 [209.85.161.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4159110E776
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 03:02:21 +0000 (UTC)
Received: by mail-oo1-f45.google.com with SMTP id
 006d021491bc7-6d68de53053so785548eaf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 20:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792810940; x=1793415740; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YUo+XtntZbYcqPV2ScMpM1XRucfaL+Ekp6Xynts5zkc=;
 b=UWGqe/6HEiszE6SgwOVopSDV+LnusEyqFWdjIkiginxmGrd70meCei0ZfkZh18AdF6
 UsLLdWYURLPCkLgPhBMeAX8i1mVnhMQaocjs6uQjXFeNXKn+gRzZpqvZGeNSoqgJMxSx
 tvGqKjCnHRMXSzbNjCTQJiFOTj5P7hCDgBDZsIwbimNmr9PuMDOjoxZK5HZEgI7TgTxQ
 7dePMar+gbwCDlS2xGpEIzXUEpQMSSHdIjwC20QpF2iI7/dFOj6M+U1v+vmZmYyjNOZI
 BCHNUUSUerUDJTsUWaa44Qluxv9vik/fzI5Gbjk5Ma5GFqgU3NeCgrZ+UD7Nu3lTIEbB
 IowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792810940; x=1793415740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YUo+XtntZbYcqPV2ScMpM1XRucfaL+Ekp6Xynts5zkc=;
 b=oK4ytFqoJNoDFA0MF4eCa0p7vH9u8hFN6948Uw165X4x3J84J2QQlOD8q8UUFS43/y
 GOJgBzrXgqrqUFpyd4oMWvYgFsBjkXHX3fPLoeYhjQC1bQGnTgTHVltEuNodwiOHnsMf
 qWYd90eaKVbchrF5ta1LS/QJRMLgq8YQ4JrieZdmsDMeZXSHk78HInHBuVBrXnSur/Vh
 NaIiu5c51Hx0tbniLBWEMcyTAuatnLBbVTN4GVX1ohEUjEcuQwsyxG+9fBXUx3gjOJtL
 tTrWGVc+YZ5lispXWxomOqX82Lx1d4xUJavn2MgaT5aR2MVl0CxLYRvV/zwEqv2MxYO7
 Djpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzH6mqdwCO+zLmUcvC3jnRTBoL0H/paCF7ODDknDWzvtjManLtcU4ePWkwUZMvrXiHNORrYH3PbAQA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ6nV+jJc0D3mbbdBk9NX5OmuSX5Bt2LtkhHpy0tRU9S4mYp6mh
 rCkvOXzasFfGiI5kmrgmQqq8ZAi/Z0VU4echV+ACaOXcMi4rwGg3SJOR
X-Gm-Gg: AYBFou2Z82yIv7ILWnTCaF6BkqWBXcEQXK6qd+rwih1/qQeWkfv2tR6w2zIVZhvrKjR
 Y6cN8qIr1TS/z/gtwj96xQHZJ97Y1cablJlLXkfpemxkV/IIpve46BnZytp9piwCN0kIt0EveE2
 UJPFuIPkkfRr130ZL/OmA/KsaqzPvrLaXORW3wb3qGBJ5/FhJeBA3hmsTYH3yfF9K7QzeVYFy/F
 vV1KYreHs9Yh0dUmoZag+B/rBiJ7Zps3eOua0ccpvFBB6mT2KHJlO4xDLAKoGXMupZjSRvXyWFw
 67vrIImcZSJCNjS80vAsEoaUokRhWXhzOCKu8XoRW//RGFnLKSyCPywKFl+qNLGem6Z5+USIr63
 5Jk/YY006e8SQJeG5Sb+mJM6qSFWb3o1dJhSxN2Qx2+N2urF/3+z53SXRagabCp3WkWkzq6ki+E
 OszFigCkuFf1kzF7vVlqknKsM+2+eb95TkuD5HS93OC+Z4csnc2j5qE6UoJ08anhTBO31ugTqSe
 P4rMwaRnBaws/UbzN1M2Z0Lhvzi9k15vgzRrGQ/zJD3B40kOI7krshGrrKD8B1mjPMNtqnIuybS
 HMRr
X-Received: by 2002:a05:6820:1344:b0:6dd:1d22:8573 with SMTP id
 006d021491bc7-70ba0f02572mr353232eaf.67.1792810940397; 
 Fri, 23 Oct 2026 20:02:20 -0700 (PDT)
Received: from jeffmr (63-152-17-145.cdrr.qwest.net. [63.152.17.145])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70b9e1fa334sm824552eaf.9.2026.10.23.20.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 20:02:19 -0700 (PDT)
From: Jeff Roach <jeff.roach0@gmail.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: mahua: Support GPU and GMU
Date: Fri, 23 Oct 2026 22:01:25 -0500
Message-ID: <20261024030142.13643-2-jeff.roach0@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925-mahua-gpu-v1-5-0fa0bfd8d315@oss.qualcomm.com>
References: <20260925-mahua-gpu-v1-5-0fa0bfd8d315@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 Oct 2026 22:59:00 +0000
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 25 Sep 2026 02:44:36 +0530, Akhil P Oommen wrote:
> Mahua SoC has a new GPU called Adreno X2-85, a slightly smaller variant
> of the Adreno X2-90 found on glymur. Override the compatible strings to
> correctly support it's GPU and GMU.
> [...]

With this and patch 3, the GPU and GMU probe and render correctly on the
HP OmniBook X 16 (X2 Elite, Mahua).

Tested-by: Jeff Roach <jeff.roach0@gmail.com> # HP OmniBook X 16 (Mahua)
