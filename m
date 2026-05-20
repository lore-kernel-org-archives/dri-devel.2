Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2741CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 08:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1257D10E099;
	Wed, 20 May 2026 08:07:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jbrjWaJo";
	dkim-atps=neutral
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2BF110E099
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 08:07:21 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7de46b8e432so4638299a34.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 01:07:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779264441; cv=none;
 d=google.com; s=arc-20240605;
 b=SqxAvU1BiJG3irACpzdmvCmjL74y5BnqERxko2QtjVB2CWIt1G7q4zhG/gwKIPwLti
 iUhuFPSzSrSx2Kg3HCRYWHDUauXDFF0++LqqJu1JlxcuAoFOjFRnkqHZrgtTFDqp+Zhw
 E3xDED3ZMhR26zJ7E3EkgD2phfATwkY/D/AmzcoLgVHDbLQN0skcoDewzXGY/K0NA8Yd
 dnmAKch57KcNGsh+MGpJvywNG0fipgTixs+KXTmpFD9PFKja7G5Lv+elUE7FD/x4/vf4
 mvdSEorXfWosXNglyp5MlHzxhbHQP8GATsRbeV3VnMxsIi4BhQTaq63ZY6VwntwfWlhc
 6Hfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ytey4qORX2TbyVZpIBqgx3oRXsMx32wxQcpaf7l+9+M=;
 fh=p85yQhIr2lM9GB5CxdQo/fnb1Xp3/loNCxrLRkqVZHA=;
 b=VGutwQHcI4pjzQ2T21Lt5SQll0w0ueexA5l+FLAUMc/mPUlwv165t9h9Dft4m21Hin
 kbqKcfUs1E5uoIrFZWIRs53XECMbeDh0jwG+BxwEsyiH0Fm+VxIuJf6E6FesCHaQxkKK
 1vpDtMw1i9sLKcdXUZ3oQMPkzis/nXfzVrDihx8apCB+Mq98PhaJBXMf/aOslnOnwHJ9
 hzXZCu3REu/B35JtNXUMzIEpvYswwbI0u5wkMmhZt7Q1wCcWe3y5YRZUtj69y/js9RTP
 dw+fCIEONUHjIrPnWO7BptHk7Vz6mhuz48Z9qSRZ1xm7EM/KIH3utMYwsxJRyWjWv2cL
 z3Vw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779264441; x=1779869241; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ytey4qORX2TbyVZpIBqgx3oRXsMx32wxQcpaf7l+9+M=;
 b=jbrjWaJoxGzpQfQHkJGH8PnjwM4tP6vqjfT67A4BuASLJ1NzASjXg5hxosvQ1y3lAP
 75oPDXESBc5gEEBD2Oa2YDVjl/bv/1R9JI32F0/BXlm83gFB24Y6rGAsb5Ux9E+c/voC
 SRaU/9rZ6TntxwB0xL39DOrJHAUUMJqVA+nCUddE8zHRG+PvbV6TjrZe6LyYiDiRCr3J
 UNT8OwVZyPD9U3k3LfadOg/Ook96PWeh98lSMqnqy+47dmfTBx7MU+HtMYnzcBlrkT7T
 f1my/qY5FXD5NRgzOS2jNtED5YbIRIcwx/zZOAKRmNip9JNp/ShHQMgn8rhMjPieyPnA
 9TRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779264441; x=1779869241;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ytey4qORX2TbyVZpIBqgx3oRXsMx32wxQcpaf7l+9+M=;
 b=Uw/NzZRonalzy1M/X3ijJgT5UA61kvN9uC7Fs1Gtl/4q9PeNskrikxu5EWm/f2WYYx
 WZNoqdZOKB2+Y6cvw8L4fVP4X0V3TA6MrrrHMmBqVSZLMFNEVQtqAzbBijbnGXhFQmKM
 NGGJ8YIc4JmqG+x6LjrzeOXXEsE914dDq6oQFyMnAVkt2KcmLy6Q5CJUyk+Uk1nzs43r
 jXyPHqT7zowya0P8jm+Yt1HJYZvLaybBE80sc0YGnSkub6d6n3MPXfHVc8swT1n/otCI
 u4IWlFnUs08W0VPanrTJVvCUuaA+NOm3Cwc5tIoIt50DyDvOr/i0iLBZK3VXYLJWUmQ3
 sIag==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TwsdBT2qYbVPwTmfUj+2J8Mk0uXFh4KnxvEe4kUfGZlDOBS6KmotKjTEOc2M1rxnmHztsSXccyyg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyO4WLMzE0F7z+jOxBjZ75cej7yYpEK5dd9SGJAhj8bXVHp30F+
 Qs8sXyBSZBmeP5D5MgpMgdHo2hHdb5A4ubCBJFE2lT4HwgsP6zF+tPDTyCJR1b+7HDHp4qHIk3t
 +9wVSWVHu1CUMB+GGZ+Tutj20k55aKos=
X-Gm-Gg: Acq92OGeJni/od0cyrokx3BU95t7BHzV30aH3pHK9siwors97c7wwrw2i7So/fOiWvz
 GBVMHrNatMIWFLKWunSseRf2H20Kyd/C/cSnXqymKFbM56gU3bSzopeSO90XqKgACEc3EGIfxvk
 vaR6orP0wtGU0OUwjVlHOsR83T/InnbI8et1yOe5OPdbvDFIkNgYmsonSpKt7MjAB1dvF5GUsO6
 HR4ZV3CHlJipsA7ZuP/+jR9cjMBzJT6M9dxZcer6QeDmr0v4+MJW6EySgQm7RflcNJtnQRGeU2a
 qGSA1UhuWQ==
X-Received: by 2002:a05:6830:928:b0:7dc:e08d:d9ec with SMTP id
 46e09a7af769-7e4f2b24e30mr16828017a34.15.1779264440957; Wed, 20 May 2026
 01:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260429143743.50743-1-mikhail.v.gavrilov@gmail.com>
 <20260519161541.19994-1-mikhail.v.gavrilov@gmail.com>
 <45bbcc75-f852-46c2-bcff-8cacb9413376@amd.com>
In-Reply-To: <45bbcc75-f852-46c2-bcff-8cacb9413376@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 20 May 2026 13:07:09 +0500
X-Gm-Features: AVHnY4LjCbKcTkLs9-x5er23_LG6HLKFdPJe4uy4QSmttSvQ2RTUpYxe2TP8aBU
Message-ID: <CABXGCsPRY+jk_ArYMOXqNTw31W95FBgNzqFq0_pvi3paYR=KDQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix recursive ww_mutex acquire in
 amdgpu_devcoredump_format
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, May 20, 2026 at 12:08=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> That whole infrastructure is superflous. You just need to modify amdgpu_v=
m_lock_by_pasid() to take a drm_exec object to lock the root BO.
>

Christian, modifying amdgpu_vm_lock_by_pasid() to take a drm_exec turns
out to also require converting its other caller, amdgpu_vm_handle_fault(),
to drm_exec =E2=80=94 most of the diff is that conversion, not the helper i=
tself.

I can:
 (a) convert both in a 2-patch series (handle_fault becomes
     drm_exec_init + drm_exec_until_all_locked + drm_exec_fini, ~30 lines),
     or
 (b) keep the loop inside amdgpu_vm_lock_by_pasid() so handle_fault stays
     a one-liner =E2=80=94 but then the devcoredump caller can't add the IB=
 BOs
     to the same ticket, which is the whole point.

(a) seems unavoidable if we want one helper. Is that what you had in mind,
or did you intend something lighter =E2=80=94 e.g. a separate
amdgpu_vm_lock_by_pasid_exec() leaving handle_fault untouched?

--=20
Best Regards,
Mike Gavrilov.
