Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169EDCD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 14:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 577DC10E5A0;
	Fri, 22 May 2026 14:41:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WefCqgMJ";
	dkim-atps=neutral
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FDE910E18C
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 11:28:31 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-12c19d23b19so8130290c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 04:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779362910; x=1779967710; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJyNQp/avb8w2S5x2BnqyHifPaEtYXGBN4t4d2EgLfE=;
 b=WefCqgMJK0GtC5BiPz5F+pQ3C2g4xzuB4yQObM9fjnWVBmkO5z4fTX+Su6XNy+ICBF
 +w+vbwhLJ4tB7hbWqVKyfnenr1rVfL11T2oWOW7xEYVRJZks9B9EaSK+JqFyGs0ItZKM
 7DjgsOenjcTJkaQR7IbZJRia4iLEhEPmxFF9HMRv36qholbLFNqyqYRo3X1d1EoYzKIp
 7VxtstV8tOWM00g4gDXmumoGfWYfBnv0JrWN3IkfqJsR+Wn7UPlspcjfUcWEiMb+iDaC
 c0DdLkT2DMF5xuFuAw5Vla2+8LfsQNF2mnu8V9bkLAvf8ntIbIjrFGioBpt9HO9WX7vh
 NXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779362910; x=1779967710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lJyNQp/avb8w2S5x2BnqyHifPaEtYXGBN4t4d2EgLfE=;
 b=gd3RDGYcTY66bajQxtM6446R3xzMgCw7xMJLb7DMJPiCInLlVM+mdz/tb0fZuRcAOA
 J63+7sn/DImuxiO8GYqu7Fu5F0SZpge+AIuzwdfqr90gyuo6bywISg1JEasRgUmDreOq
 yOfUGvMcGBhObIAmKMHhGinSWR1YcYbWKNrqGwE+AXGAtjUL0EmUI9hfzDBJLRoHusSl
 xkU/vehWm5MGSEzDJ0PRlJ9H6Fu45Me06w65wp9vKEh9j9HA1DFY6YWR5ObirccEIqXp
 pKcXFFcIRG0JukAcSGIKeCAesw9I8NQ4QsMWU0OtmG8Ja4KWS7djg/mlOUyEdDJKi63p
 FQGQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8d04cQ+gDDhsmwabccj86fY+hLdQ1ZDOWZyAklVO6k2pBA9pkjZffuYqIXaAYVCm6PxLi+RJxIGLk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzxbbB+tZJjttcyjjnIyEyt/sgwLi3aYC2SJW94uXxqFKGqBC3u
 soZEMOjeBjECTniT99LmdSYS3yXTruFVQIqLM9Lk14S6IrdrKUEp+NXS
X-Gm-Gg: Acq92OFh3ljb7ensLA5ogEKS30J2yphvZLSUp9yTeGF5sQFhNbVAdzakxvGvjw+k7FN
 Q1P+sxUiFQKv7K1LFpTk/hWM0VinNE9oN67IRQ10FEuktzmYwIsbOXzeoDWeXgoXf9CTdtxSf8Y
 IGMGImzxmT1Glr5D+KhWfnt1dDUBNZOCBBC65f1EjIovWKLHlFitln8CaetCVgF2aCZWFflGwtb
 XSlLJROj+SPPXvbaoPtw1v/Llu1FdqWaJ5vC2wtns8HMp0a1JV+0qWeSmj3qJYnQLjjEmQGxZ6/
 5b9FfFUnNomY61+fC+Li2l7HLjOqKr/huDQyq9MMeNUOQOhWlmofDwbtzW+zn0/sQekLPxKL2QD
 +K8uH/sLcx5BM4V4J0SvWbTdyfc2ccHt1XKhUE9Ty6jMEh16glSoOpbVmpEhiMH2hgJhsGVHcgF
 Lxua5LkAbIQgSH+9+yEqOR13Inu2/j+2c=
X-Received: by 2002:a05:7022:42b:b0:128:d7a7:5271 with SMTP id
 a92af1059eb24-13632e57813mr1088992c88.28.1779362910227; 
 Thu, 21 May 2026 04:28:30 -0700 (PDT)
Received: from wujing.localdomain ([74.48.213.230])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13651ae2824sm56138c88.0.2026.05.21.04.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 04:28:29 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
To: tj@kernel.org
Cc: dev@lankhorst.se, mripard@kernel.org, natalie.vock@gmx.de,
 hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/dmem: implement dmem.high soft limit and throttling
Date: Thu, 21 May 2026 19:28:25 +0800
Message-ID: <20260521112825.62249-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ag2EWbmlWhK2a3zz@slm.duckdns.org>
References: <ag2EWbmlWhK2a3zz@slm.duckdns.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 22 May 2026 14:41:05 +0000
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

Hello Tejun,

On Wed, May 20, 2026 at 09:52 AM Tejun Heo wrote:
> I'm not sure about complicating dmem control model without implementing
> reclaim. What are we slowing them down for if the only recovery action is
> killing them?

Thank you for the feedback. Your point about the lack of a reclaim path 
is well-taken. Simple throttling without a way to recover resources is 
indeed incomplete and inconsistent with the cgroup v2 philosophy.

To address this from several perspectives in v2:

1. Recovery Path: As suggested by Maarten Lankhorst, we will pivot to a 
reclaim-centric model. Exceeding `dmem.high` will trigger a prioritized 
eviction process, where memory objects from over-limit cgroups are 
targeted first for reclaim. This provides the meaningful "recovery action" 
you mentioned.

2. Backpressure: Throttling will then serve as a secondary tool to 
synchronize user-space demand with the kernel's reclaim speed, preventing 
bursty workloads from overwhelming the system before reclaim can finish.

3. Graceful Degradation: For GPU compute jobs, this model provides a 
managed "pressure point" that allows transient peaks to be handled via 
rebalancing rather than immediate, fatal allocation failures (max/OOM).

The goal for v2 is to achieve convergence with the `memory.high` model, 
pairing prioritized reclaim with backpressure.

Thanks,
Qiliang
