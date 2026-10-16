Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416BECCF2C9
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96BAA10E6A0;
	Sun, 18 Oct 2026 14:54:36 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E107610E2A3
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 12:41:04 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-cd623dfe420so2444301a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 05:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792154464; x=1792759264; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0kuUNpKGpHmxXwciJw2YT+q4uhPu0mOIC0xkYVCIOFs=;
 b=anOgdFzrU6K5UE89sLO5n634172audRMy7pEPE6hLy299pPdZMjHjQgEQ4qXHRTKLn
 mPhoMFpH7nMtkgynZ1RMPsvV4CU87QlXc0gCDt2mqvuYoOjCaAq8BSEBN2T9SWNcZtJq
 joXBDBsCqQMdErPQbkAJokLv2pOjkdcjgWumnN9o6DdIcp5lzZEcjoxFbenEiZ22i5uF
 cilnGxz84H86lrA3hEltTPQf2WC5KlOctCORApa+YcS+lsPaSNqQAPZDtV3HMxzsQBol
 2qSlNcMFjPsFcWq3yUDJMoHPSP5pVcCcPUAexhPh+2qtFATEPEezVPhj5auo1O00pqA+
 1xsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792154464; x=1792759264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0kuUNpKGpHmxXwciJw2YT+q4uhPu0mOIC0xkYVCIOFs=;
 b=xIAchm+UHoVqmv7LaGVgCUxpN7KYYkPupamU+/91sOs5Vg+QiTyP49ZTlTO3ND4Mrx
 VCbxy+0jNeYgvrMXouBGLnmDt6fBOGMUw2XTp/OIPoMlC3KO5pjSd0OeWNAxYyW+AN8b
 /ZLaaHnVEFgF08m/tNqYbAIBq/Tg1WFdtBfp19aiH5HgHxlz382dnf6cjpO6QO7JFEbr
 IMn1dbEe8sF7kSctvKiZvMFUglCASfKSW8JCenmi5hdmKQeBkCHmGEWDrIiNx6rK55bD
 lpPDLj0mrENxhdA2CNiVmScx6sd8VvhYvkj2vU6U/7uoyPn2Z58zEP/2JIbjuRHhrfCo
 YEww==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGK8M+qb3dXtwJjV4ELPkOX7AWPqsXRvlwfhRG0qaajD7U5uE3FNu+cwBL4Nc1sDRg883p1a86vyI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJkj76tqQGwjE8QuEBrdmGAZn1RcEqFuhtyR+XP+qBmHXujrmR4
 1AqddJaFCNcMXhPlIUDPKefN8tHcBy+iBGfctnIJYUNRhTqg1msXNqj3
X-Gm-Gg: AYBFou0YA4sl4FhsFaducENWrMBBshopwf142pP7K2SA1nUVAw3/ddey7dj9wUDvHQN
 +GdVCGehMudbQLt4LczXSKc5eTnscSUj85qIq4R1zabwDkMlszzy1yNWOho/c38Oa09HM1D/1IS
 ODl+hQN/OffwrV5H2MMbPGeJhi+eq1Xf7FiP2ttiBoAxybd3UMxF/+1yQfIxWM2+IaoninhJjyO
 8CKM/tpT3jiirP3aycGKnGVDtaxcv1/kBoHbxVSsgJ+eHKS8a4Sla+u/i+mcLUlr7vuS9DAxpSY
 6OLYl44qQbI1JDLNtQlRR5DZEF6z7nDd00aGysShpzd9JaekfeSMc7TNfajJP/pPFhvt05jxZYP
 0DINm8my6DeI1fjvM2300AEmPlxge4Djk7IRDAlplxJFHf5Qhj643WEg7gjJgS3pED/UjhDuW8o
 06jtmH1BsCLz2rOA5gjzTyTqaCDP3FsWzve2+C8kQEt27vJkOPkpS6xAElPsHSvLZpWvmoBn+oY
 JsYplW+OEwKQw==
X-Received: by 2002:a17:90b:3b84:b0:3ab:1b19:78f4 with SMTP id
 98e67ed59e1d1-3ab3a3a11a1mr21060267a91.6.1792154464234; 
 Fri, 16 Oct 2026 05:41:04 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc46ebe40sm4180541a91.6.2026.10.16.05.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 05:41:02 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/10] drm/msm/dpu: only reassign resources when the
 encoder is reprogrammed
Date: Fri, 16 Oct 2026 21:40:55 +0900
Message-ID: <20261016124055.1232-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261003-fd-kms-fix-smmu-v4-9-2a44d4d8ac77@oss.qualcomm.com>
References: <20261003-fd-kms-fix-smmu-v4-0-2a44d4d8ac77@oss.qualcomm.com>
 <20261003-fd-kms-fix-smmu-v4-9-2a44d4d8ac77@oss.qualcomm.com>
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

On Sat, 03 Oct 2026 03:30:24 +0300, Dmitry Baryshkov wrote:
> Reassign only when the encoder is reprogrammed too.  Enabling colour
> management still needs a modeset, as that is when DSPPs join the
> topology, so ask for one in dpu_crtc_check_mode_changed() and only there.

Tested with 7/10 and this patch on v7.3-rc4, with out-of-tree support
for a Lenovo Legion Tab Y700 Gen 5 (SM8850, bonded DSI). A compositor
sets the CRTC CTM through the legacy property ioctl: NULL -> blob, a
series of blob -> blob updates, then back to NULL. Over two such
rounds, counting msm_dsi_host_power_off/on with kprobes: without the
series every NULL <-> blob change was a full modeset, four in total;
with it only the first NULL -> blob after boot was, and the blob ->
blob updates and the clears were plain commits.

That tree also carries out-of-tree SPR support, so for the test
dpu_crtc_needs_dspp() also returned true when SPR is enabled.

Tested-by: Joonhoe Kim <26rote@gmail.com>

W=1 warns about the kernel-doc of dpu_crtc_check_mode_changed(): the
new helpers sit between that comment and the function.

A CRTC now keeps its DSPPs after the CTM is cleared, until its next
modeset, so on chips with a single DSPP (SC7180, SC7280, ...) another
CRTC asking for a CTM fails dpu_rm_reserve() in the meantime. Maybe
worth a line in the commit message.

Thanks,
Joonhoe Kim
