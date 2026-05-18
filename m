Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43B5CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B214210EAAB;
	Tue, 19 May 2026 07:13:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i9LdfNzo";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C30810E924
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:49:05 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-367cbac9c37so1275559a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 12:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779133745; x=1779738545; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CSdd+NX6WkTu8lhAsB8yG+c517QF020QYelPmR8Wkrc=;
 b=i9LdfNzosmErqwQRZ/KMKykSct/OjLFKWyeU14Y0/TdMwezZP4q/3TdK6m/1eZP8gS
 gqVtS0Y1y+TkxGlQFhvA/nwV97MjO3zPh9iqCIeHHxHe11vfadQfy2wPMHx+CRXcidPs
 9WOgP5IpSw/1vgmpJC1jQRbEg1n+6mGEQM8FudyutxEWV2vCnof3ivPYBOo7wF9dwh4m
 Q38MR/p2Ty3JoH41BDjf5Ju9wQT6u78ouQFYLpSh9zJ30qQargdjvrx5d9GhKKUMAjh5
 EVMzO8FsTk2K8lBC/OgVjNUVPi8giw4KS8TyOXKpd6fbp6xVJThoNGdo7s/P5jXeHLVH
 nCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779133745; x=1779738545;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSdd+NX6WkTu8lhAsB8yG+c517QF020QYelPmR8Wkrc=;
 b=fGeb6Lxb8ej7T6KBbalJ9j6Ye8SyAmrUz0IN30KDrwP3/Rbi+cg+C+iLY4uTdn0TSG
 +qkLceD+gmO+8HA45BQrNSa1M8Or21IowhwwtRAwAQS922oJftL/5V6p1IgOWPAjOMTn
 ODUscYdl0hOqi/puYH4FkE10U5UsRIYuvNgrjxQ2XvSnZLKBiara5xXS6bI4XurGShE1
 wljG+10irdwGl4zT0cOB/bUA0jD3SySqDFl+iuHwQx9zx3sMYhnhbKMxLejgOOnW92M5
 LH7LM1g8/pSKnulPR34CUO/1XNB81gPMEY27MVM8LTrsOwBwy1+k2fHG05SnPkIZT0MJ
 AKkQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2bRFYguWAJL6Rz16QkHEhrmdTS/VegZIXyrZegfJHrbHlkEIWHuhJvWMgLXmu7lIfLJsNxOJHtys=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy2kfvMvaPur5R/otIOOcjYKTDlJy9B+K+JxdvOba+i4wN6Af5E
 kMJXXbrQW9G26OYRtgHBEx/bYqjNM9u5mtWZH7VmZ/jHKDFdAapz3NR2
X-Gm-Gg: Acq92OGh4E024qtUaLHRAth3ey3aqn3MGh4GMiRZ0hV5xQYmzM/541as04jbRngSibf
 bMmH7DcH93uT1mmGixIFEUrNs18mUvMBMrVOwqSb95X5+kh9sazy7gylqyaM/u1FvJYtK6XMdi5
 VItA6sJVE54iwyobuWGLxdLzmfdylUq+r+SSt5TUrVPiFeYFzj/y50LVXERr3HBiKJ8f5WSEC4K
 I9K86eSaccFfACxJJFLiJD+12T6UwocyuTaVR2diWU6p5O9z5lzSqC2ajl9LukNiRPAKit2ZqLL
 pAXAvPBJS+rm2/0qUWEkHqNcTxhyJnniAAM3Y0M1YQkrshgP+pfa7JtCO6fO57cbtbherWnZlgi
 sqK1d44hvqtXi8gLITPQ9ihKxGNjpYXhMGWylPxNnR6/crG2MruTDFblBw98kp+hNwZlgqyPP4y
 aVwkLVhLGfX5HPTPB3gd3M0PgVI3/j6WyRpJhbyTJsOtd5CZFxJj2040CSDjwIKDKEsx3lDA==
X-Received: by 2002:a17:90b:1344:b0:366:4782:138c with SMTP id
 98e67ed59e1d1-36951b971ccmr16986854a91.17.1779133744962; 
 Mon, 18 May 2026 12:49:04 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-369515895d2sm11635928a91.8.2026.05.18.12.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 12:49:04 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: drm/nouveau/tmr: iterator used after loop end in nvkm_timer_alarm?
Date: Tue, 19 May 2026 03:49:00 +0800
Message-Id: <20260518194900.1672140-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 19 May 2026 07:13:01 +0000
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

Hi all,

While reading drivers/gpu/drm/nouveau/nvkm/subdev/timer/base.c
I noticed something that looks like a past the end iterator
pattern. I would appreciate it if you could take a look and
let me know whether this is a real issue, and whether it is
worth fixing.

The site is nvkm_timer_alarm() (linux-7.1-rc1, around line 122):

    list_for_each_entry(list, &tmr->alarms, head) {
            if (list->timestamp > alarm->timestamp)
                    break;
    }
    list_add_tail(&alarm->head, &list->head);

When the loop walks all entries without break, list has gone
one step past the last entry. &list->head then aliases
&tmr->alarms (the list head) via container_of offset
cancellation, so the insert lands at the list tail. That is
the intended behaviour, but the access is undefined per C11.

Jakob Koschel cleaned up many such sites in 2022, for example
commits 99d8ae4ec8a (tracing: Remove usage of list iterator
variable after the loop), 2966a9918df (clockevents: Use dedicated
list iterator variable) and dc1acd5c946 (dlm: replace usage of
found with dedicated list iterator variable). This site in
nvkm/subdev/timer was not covered.

A candidate fix would track an explicit insert_before pointer
initialised to the list head (&tmr->alarms) and overwritten to
&list->head only when the loop breaks early. The observable
behaviour is unchanged.

If this is intentional or already known, please disregard.
Otherwise, I am happy to send a [PATCH] or to leave the fix
to you. Thank you for your time, and sorry for the noise if
this is not actually worth fixing or has already been spotted.

Thanks,
Maoyi Xie
https://maoyixie.com/
