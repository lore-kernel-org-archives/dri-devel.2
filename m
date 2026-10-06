Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF96CA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:09:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 455E010E1E0;
	Tue,  6 Oct 2026 08:09:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qH4ZnIZg";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 579CA10E1E0
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 08:09:58 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2dd9cbb661bso3882065ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 01:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791274198; x=1791878998; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Eok7DWYmFOkeuFX4U4OhvywDDaFg642GCVXSSU8R3s=;
 b=qH4ZnIZgbQk2i15+fAEIRudB8NCvBuDpj0J6dt/e52+y22wFhVJkWBwrtxIVnzLtOf
 MhhOqRNHQqa0zVYZgwa9PjXYSMIIzJebM/6CEtAxZQ/UDMZi9+kDNdXDO1dluAo8P7pr
 Og/7+X+GQb94pPiXa92/jeDT+p5pe+zOe34nENjva6eFbg4jXCf6OnCwpH7Apw3hHnPW
 xC4+CfOJmdzOGKdfsE2cTvLQny2zOrzIrVvFD7TGsiYXR7pgvCYgTVt0/thzHUQpBkXq
 rJnW1/1II+KDQRkkli0s5ck1zCwt+yUXp74dGlFehWw5ObqmUnUm3TByuC6grIUyinvD
 0H4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791274198; x=1791878998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0Eok7DWYmFOkeuFX4U4OhvywDDaFg642GCVXSSU8R3s=;
 b=caqZ6zNojfbmn26e00xR4j+OmSwQfhCsmDss5QaPdfyilC8WtOBG7FgPn6RNE5EOIi
 yHw/7FQ+F7jtzfq+K7s5guyN8UZGv59B11cWOr/C6mVq86/4wV3Qm4S//lRZcVsy2Ocb
 T7R09BBmezmOmzUg19lxOIC8VzAIe+q85sv+KgAgoSlquiogckdCcgxNYJK7FH7Li6Om
 1M6rVJl70/UZbL0tVrxNLEoLl/tiEBGulyA7Pe5hQzcj+aEppCcwPoBV1EJ7LGKz3dys
 wGrmsd5TTjGu2m6h4QV+oqdHYfjpAWUvC/IxddAXw/oLQsViHjpdn803+rmRTA0P0BeC
 M+4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbXWhjBsb9nbgoTwuGFBN+LhCi4LUpxZto0lbj+7z28aQa1bnkvjiXAwH+UwzzBuCpb0ky3VJ+izM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJqiJZJpJJvspA9/SdfNNMgg5LUH+Y0cMOjUIxAwSEyfVIEULOx
 vJKW6sqXm1UOSbE4j5FdVJ5BOYquPzXnc22mRDZcWyfqSl/fA0S+YXB9
X-Gm-Gg: AYBFou0HaT9Ljmol/SI+mbaRBOmCh789dgNHaZYdOnyua/GcU0O3T15z0pIt1WerytN
 mDZe/+nc1n8LHUvQUe72Mk5e50q8UHU3mHYag9uRdfOzYIQ+aP4b6ra+aPccUWkj/bORLirPht7
 +Re9wDZSQ+Vn8SzIiOPIyGzd88rfvpSzgue5JBYycvCD/qnB83STTSY2GYXGtsOSl+pT4eXDQlI
 jZquNdjNbiz6x7vAfdMnwK3sbGqvRR2I8N1HBMLqgHUna4oAt/hZ4ZlJ3YUkOwVbbwJxbmFCfwB
 ed09US1IT05cYWGHGaJNM2p7u+d+MmqlyyhvLvFdhw++1Um19AGQjqy7k5+eDaMBB724M8n3Ewm
 UyrmxzPMwc2ToTLtoT54tB46G+8F1nNwoq+2LBhVSnzsu5AboQKuGNmNbVy/d85j/3uplY6Q9fy
 mvxrSznLMHTNHyZh04MdfG7XZDbwi/WtTthcLbOJbpDjcTYH4xKhkyTvH5XHCtrd7omm7/u+e84
 qFhhdyxbnlIobNBPWYHPJo1VizLWGaYVy7ls1RbDZzN5tnN34rEnLpb9lkr85zfQN47BJziKsv+
 W0Zyc7KRs7lpHujaYNOEMC3sAk+9xHCvp1hcS60SPu0dJ3Y=
X-Received: by 2002:a17:902:f602:b0:2cc:6018:f030 with SMTP id
 d9443c01a7336-2e5dcd9093amr7496675ad.14.1791274197752; 
 Tue, 06 Oct 2026 01:09:57 -0700 (PDT)
Received: from 0xiviel.ip (122-63-128-121.mobile.spark.co.nz. [122.63.128.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e5ccdd1f8esm6046185ad.83.2026.10.06.01.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:09:57 -0700 (PDT)
From: Eva Crystal <0xiviel@gmail.com>
To: yidong.zhang@amd.com, quic_jhugo@quicinc.com,
 karol.wachowski@linux.intel.com, max.zhen@amd.com, lizhi.hou@amd.com,
 ogabbay@kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: sonal.santan@amd.com,
	mario.limonciello@amd.com
Subject: Re: [PATCH V2 16/20] accel/amdxdna: Finalize runtime PM before
 acquiring dev_lock on removal
Date: Tue,  6 Oct 2026 20:13:10 +1300
Message-ID: <20261006071310.198186-1-0xiviel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006042230.547807-17-yidong.zhang@amd.com>
References: <20261006042230.547807-17-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Mon, Oct 05, 2026 at 09:22:26PM -0700, David Zhang wrote:

> When the device is runtime-suspended, pm_runtime_forbid() synchronously
> resumes the device via rpm_resume(), which invokes
> amdxdna_pm_runtime_resume(). Because amdxdna_pm_runtime_resume()
> acquires dev_lock, calling amdxdna_pm_fini() inside ops->fini() while
> holding dev_lock in amdxdna_remove() causes a deadlock.

> -	amdxdna_pm_fini(xdna);
>  	aie2_hw_stop(xdna);
>  	aie2_hwctx_sched_fini(xdna->dev_handle);

This is worth more than its position in the series suggests: the deadlock is already live on shipping AIE2 parts, not only on the new AIE4 path.

On current drm-misc-next, amdxdna_remove() holds dev_lock across ops->fini(xdna) (drivers/accel/amdxdna/amdxdna_pci_drv.c:457 and drivers/accel/amdxdna/amdxdna_pci_drv.c:463 at 34e9ab018249), and aie2_fini() opens with amdxdna_pm_fini() (drivers/accel/amdxdna/aie2_pci.c:640 at the same commit). pm_runtime_forbid() then calls rpm_resume(dev, 0) synchronously (drivers/base/power/runtime.c:1672), which lands in amdxdna_pm_resume() and its guard(mutex)(&xdna->dev_lock) on the same task. The base wires RUNTIME_PM_OPS(amdxdna_pm_suspend, amdxdna_pm_resume, NULL) and aie2_ops supplies .suspend and .resume, so runtime PM is active on aie2 before this series adds .runtime_suspend. With amdxdna_pm_init() setting a 5000 ms autosuspend delay then pm_runtime_allow(), an unbind or rmmod more than five seconds after the last NPU access hangs holding dev_lock.

Three things that would help it travel:

* Fixes: 1aa82181a3c2 ("accel/amdxdna: Fix dead lock for suspend and resume") looks right. amdxdna_pm.c had no dev_lock when 063db451832b created it, and 1aa82181a3c2 adds exactly the two guards the base still carries.
* Cc: stable@vger.kernel.org is warranted, since 1aa82181a3c2 is in v7.0 and later.
* Could this be split out to drm-misc-fixes on its own? At position 16 of a 20 patch AIE4 series it is unlikely to be picked up as a fix, and splitting it stops the fixes cadence holding up the feature work.

One question: amdxdna_pm_fini() now runs after drm_dev_unplug(), so pm_runtime_forbid() resumes hardware on a device already unregistered with its user mappings torn down. Intended?

Eva Crystal (0xiviel)
XSource Security
https://xsourcesec.com
