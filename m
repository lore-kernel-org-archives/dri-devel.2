Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAD5FB44C4
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:45:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC3AB10F3B3;
	Fri, 24 Apr 2026 07:44:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cVPFfswH";
	dkim-atps=neutral
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFF0710F25D
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 05:39:17 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-79ea87af213so119819677b3.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 22:39:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777009157; cv=none;
 d=google.com; s=arc-20240605;
 b=f9cpLiUOcULQGuqjI1JCHAWkVVvDx9rX8Q84J4mc3DwEL1+qCLOnLDgMjba7CmOI2D
 yLoUZmypZTc8n95S20w3N7Pl6ESgMzpfzUQcuDE+3Md6cB3pV0OxsWjl3jJXzNRNGQlc
 z+Wx80lX+ygdSxBfb7ylQhuLB75zFD/3FrPfcswUIQoM8id0MuSRUGsdvsLXQUWvgJQ1
 Hdz25Nq70+ABXBLygzEwLbDWRk8t3lxdxTKRx9xZfjBeShJn8JqWvnt73SYJacMgr8Rw
 VbkGbD8+N/1KpIO2rWDjHQwN8QpB8rVsY/9ajfoJIkxjI2GBg53cQkBJzRAZZRyO0hgf
 1ZVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=z34Ce0E4jDc10jlWxNs3qhOLP9m27M5dUJ5jC4xJNmY=;
 fh=K55naPBQUZAklJHNuAIT9+al8YFDlnib6t5ZrXCJO8c=;
 b=Zx8hfB8NSBPsIB1WVwTAh32TCGVLkeHu9almQYQA2brWGk/3MsGjAsGigYuHZduL3k
 NE+5/uH/ZL4b8ZDgqbHIF1OCe5/oiJPPP86JCG1tHEnBsdfSCMKSy1tpqiDfkrhOH/Oc
 LhUeO8QR534ca7UV0/PxqulmVH9MCvzGhmAPuMe2KdTEviqaC+8j/W7tws0yUEifBCWa
 RVEsSIM5pNxHPsFBUf245A0PzPTpVZZ1wZuDCAIsEVy6RIHG6dl5SfW3K4ZIkflSJ+Pr
 HMGYoDWYw4WFrUmmfuyhUrlXUjgsq/JcCl0/8NbC11WEF2qdfMJFm4nCapGWZmyQCH7p
 N8EQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777009157; x=1777613957; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=z34Ce0E4jDc10jlWxNs3qhOLP9m27M5dUJ5jC4xJNmY=;
 b=cVPFfswHhE7km1nOXTurHMwJgeBkwdHb3u/+jPobhTsi+Otl4cZLNco0OQDLJxwS0s
 3Y+zhqB7amVQKfWtua7cD2y3Ev6LHAlu2562htZHRqlaqPGgDcMWYmo27U1X+xmb2tNg
 9KKKSpZLIbbSWfcxwVVYB2h6W6tb9cvIonpCGQRVh6peWVaDdR/1q1ZcDSaqb9rcLrX0
 1nq+/wpeS4dy7WPk2gt1lqqQFI3HLSU6CIt4RZYGSzYPqTq7uUc/lyIXLzHR/0B956LR
 qm/WwAUYtNs39wvNDU7i8jfjvnpjLDTmzr0K4ROp+sBg3p72xBUgpFSDd5cJSUVQQTIH
 xuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777009157; x=1777613957;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z34Ce0E4jDc10jlWxNs3qhOLP9m27M5dUJ5jC4xJNmY=;
 b=TGjfyxEYAEfWvaelUDShvat9ad/gajINRA4TqH+wy9Ben0HL4hurIerIBHm/hWP7N2
 3vr4EwUIzV4s7T2/jIwJj9E7Bq6VgHPAbKnIt10rO22DLA6XQe3zu+QKNWSnkdjIsB2V
 vaWLamFRQI1xUIni0kjDW9Y/9vJq21rkDBtkrZpcjt4sA0dvusXVDWx8MylVxnnMcVMM
 TfWLSfn/ibSxaNqowEzcMUgpQaV3KYxU9T63xqh0MT3OLyzlawEPrr1wn4qVnFBNuXVf
 brmkl1NtdW7rRmagOfqyuY/lk5mYjgMd5fl/Wqq9Oja0FGfLsQ26UaA8mNa+CJb8SY77
 32Hw==
X-Gm-Message-State: AOJu0YxRKp4N9O6Eh8B16HV+GcJlUMsv5mQFs3tuOS4rmTJBCcFLpDN1
 YyRmgOsN2G1EWdRPK55ZyhC8lEIKfN/TMs7nsmQA7p962cz+0ZHR+1JKyZ0xYBGCfb19C4qQrQ3
 N8sdMTy9P/uTmAnxocMDgBaBQA+3Nvk0=
X-Gm-Gg: AeBDietzOwo5BGsN/MsTFOpm+vWTr6ltQg3WAyixjFTsR63mrvrJlzz9bz3aLgE8uOt
 Dm6Qx5ywPj7SEq/C3ZKyxj52hrvhAH4X/OhStV1NrMCB7NvjOpAqYK085RXW3sZ9669uPwVPbqe
 2RkEtrDhtKqlB01q9vlBDjL5G41JAcS+55gOZnbVWfmQwAKZZJC/PUfq5B+mteXaMJPwbv1muJF
 a+kf76VREFC+wnCBdeG6lKngNH3QV1otHgPiUfmRA4Qfv0uSbHLaO7HpenaiYMdUNmJBE1WYPUQ
 mIDCy+TqigFtaItoWUQZ
X-Received: by 2002:a05:690c:698b:b0:7a4:e4e5:390f with SMTP id
 00721157ae682-7b9ed3d2325mr223051477b3.21.1777009156808; Thu, 23 Apr 2026
 22:39:16 -0700 (PDT)
MIME-Version: 1.0
From: Ginger <ginger.jzllee@gmail.com>
Date: Fri, 24 Apr 2026 13:39:05 +0800
X-Gm-Features: AQROBzDfapa77DMPUbYojdgFW-_tfBKYcs73Tyu90eGNHpnKqx2olE7IaBwST-s
Message-ID: <CAGp+u1Y42cwE0RHhtoMEneCRTuM4k9aqKtzvXOVc9-_px49N0A@mail.gmail.com>
Subject: [bug report] Potential deadlock bug in
 'drivers/gpu/drm/vmwgfx/vmwgfx_irq.c', 
 between 'vmw_thread_fn()' and 'vmw_cmdbuf_header_free()'
To: zack.rusin@broadcom.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 24 Apr 2026 07:44:43 +0000
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

Dear Linux kernel maintainers,

My research-based static analyzer found a potential deadlock bug
within the 'drivers/gpu/drm/vmwgfxl' subsystem, more specifically, in
'drivers/gpu/drm/vmwgfx/vmwgfx_irq.c'.
This deadlock potentially occurs with the involvement of hard irq.

Kernel version: long-term kernel v6.18.9

Potential concurrent triggering executions:
T0:
vmw_thread_fn[t1]
       --> vmw_cmdbuf_irqthread
              --> spin_lock(&man->lock); [t2]

T1:
vmw_cmdbuf_header_free
    --> spin_lock(&man->lock) [t0]

T1 does not disable hardware irqs in acquiring the spin lock. If T0
(i.e., the hard irq context) occurs after T1 acquires the lock and
both happen within the same CPU, then T0 will not proceed because it
cannot hold the spin lock that has already been possessed by T1, yet
T1 cannot proceed because the hard irq runs disables preempts.

Thank you for your time and consideration.

Sincerely,
Ginger
