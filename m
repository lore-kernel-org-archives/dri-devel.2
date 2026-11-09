Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD01B606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=Fnwpgwnd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CF3610E5D7;
	Mon,  9 Nov 2026 17:39:18 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 271F410E5D7
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 17:39:11 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-37198ed3727so1545042eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 09:39:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794245950; cv=none;
 d=google.com; s=arc-20260327;
 b=MRXItFCDUUS9IYSq/yuQMW6rADq2XBDA3RPBSUYV/m29GRwq7N7VIt0lT+fHWqbSjY
 EYaJzxZwtNrPMSWoFhWdOc4yteX4l/UTUNq8R9B8EPe020Gs7ZkRyy9/AmnJYd1/RJXE
 FddwG8E00oxbsSyzNT29IitWJszEwLy/Qb6Gy8SUYD3av+nIRJfhFnM++zhJfhCM4fOq
 s+SixFOPJt6b9LuhG/mZYTzeRuyVC2RISlK6Dvc3FNsRrWIdqqZDquhkislCBGl9vxAI
 TRp9UQq6iPlxw/yoalQxPa/1//g8H35kCq8k9zF9NoyQjD7S+jzMB4Dyj7KxkDTGNMZ4
 wnxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rSkwYI9NSbNcpQAPzrN6AyhwPhoceg+lxcPAAkjt4OE=;
 fh=trO3Q5jtLc6r7sq+EFZ8mUy3D8QVT/QdHyD4CvuvvOc=;
 b=sY6ElnK8oYIthEsOxr6hPJPu8eqBqVziiD63jiK/KZ8w6ePZ13F1xDf1VDlTuHSzrY
 dncBFXnupMuOu0UL8Ocp6lCRT3KJoiB/xmy3gZhXTBtKAj8bhqDU508KWdvaMTcI1Bif
 8aXA7WYuQ+pdf9mVGXoaohiUSkAav2GEjGIgPSF9m06oloqECzg0qjC7NoxAPRVqfNcL
 nxWJt2yuDBpYaaxeFfK8R5OYgz1GA3XLsBrY7t3xoF3IlnVkybuJRptB5HiiQAeGay/j
 2q0Ou2zX8qPbqWR72tTK1l4XxVd4tc9+KQSULuEkh156WDB79plCgkPvwOSCF6WKysVM
 83zQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1794245950; x=1794850750;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rSkwYI9NSbNcpQAPzrN6AyhwPhoceg+lxcPAAkjt4OE=;
 b=FnwpgwndRLvSTIHCE5j3mDk3vjQzp0EnLJ6q9ZNdhr03ISy+bJ7VpVlvD7wIE7WVe0
 OPz+7iSvvIn6P2/da+ROsq+tDGpc+K6EoMgRQZi0Wjgry5xNTrlX/EyPdNX+HOWEJUe3
 xgAolXo4lzqwf1zWDGSAZ2EJEQd41j6ZePsxWljRUyiLXxISgbe6MuRQHhBQJJetBGPl
 w30IxrIHiTvEmq/eE/ka24FII3Lbgk+3NKYDFDY/MuiS5U5pF1nH4PfVZmPdgKaMZlWr
 /1NZHXvSSoALt9vZRRQjeVFuU8By8MgGfZ5mty6BAVppQ7vIS/oDUv4W8JNppTFusAFT
 f4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245950; x=1794850750;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rSkwYI9NSbNcpQAPzrN6AyhwPhoceg+lxcPAAkjt4OE=;
 b=An5bVSTJUekxVZ6fbpH7abruesBjycBGMwIq09f3l/0wn+6y+/moxoOyZAAdJvh4gh
 r+w3E3eq6+yTSoCOHraa3f6lCSWVBcDlUrHTx22LXkKQiU4k4VZatGONyRZDPMIo77AC
 mURkEkQEYfx0G7DPL/2wBynki4NsJcC7eyLmgMi6MGT2eJ+/gNTjEMq5MFtiF46mS9Nv
 ME0i1j4Qa/MwKxZi8r12OzV8X9PzcjeYOaGD0DtAuXhFjo7JaaQU3vS2Wkyd4yQS7ZeP
 JtsL0JOiEJaD3DHTzfrmj+kF0zFUQpD3quYyxfR0vXOoCH43PpmLcKDznRoWQidFGOa8
 JrXA==
X-Forwarded-Encrypted: i=1;
 AL+hErFmEt4IHp/li4ksOh3gD5TEWMx61NlH8EZ6j9DhAJiGLbe0QWTFDFkGl7RBGTAT0kqvqGig6WYf9ak=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/T/MjAXdHptWGdkWXsWciNTTfarpYfkRXqRTi1D8V1VlbXp4rM
 EJfmRUePBZL73qU8QAz31l/KQz5tEAPoBgGi7/Z4MM2+Y+xPGbgMSVlQ6CThlbN0PqRo7JpXQgn
 1mu5Y5CXXDSJOiTYCfjk+UjVc5URtN/fmQFzLnwfn8w==
X-Gm-Gg: AYBFou2wrDi1d/h479DZTAJOw52oGBKC8T1Yvud8PH6acUho1pEZWU0PsEsQpkL3KOf
 +j7HHYbNe3jV2c0NufkX1lWUAmjA4feKVmeQIy4CPe2fP4X/U1pjdxKXo1/oOh8eM2rnBe5AsE2
 sr1QEh4Kbf9tWeBYAIWqEx6vtpivZgpacbFQR4D0dq/nfrrrqJzGersm1GGSRi5V9YvEXFD9y6d
 Qe+EZl28Ae0iqU7J6Z4cMpbWKy1+Ad8w8GppqenQCnNURxl4CRVWNNI0+g6tltZCD5N8M0xGQyW
 jB8tBwl3ZtUuYlR/qN5wEFT5r1a/6E74JtFHrjEdeRDlYKAzizY/VFIJpdQe3CoENsSw3mKnVB1
 vgRU+BrhFufhbHjF3x4Z+rn5AzY9sT5ljMhvWnQ==
X-Received: by 2002:a05:701b:2509:b0:1a9:4d51:8c33 with SMTP id
 a92af1059eb24-1b3b617808fmr125543c88.18.1794245950214; Mon, 09 Nov 2026
 09:39:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109105652.7114-1-igor.torrente@collabora.com>
In-Reply-To: <20261109105652.7114-1-igor.torrente@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Mon, 9 Nov 2026 17:38:57 +0000
X-Gm-Features: AclHuK8aSgE_wJUkOuC6VxVrS7IisxeT9mF1GSxlNi5yHqG9I8uOwTTi-RoGh2Y
Message-ID: <CAPj87rM3_MCFMGSAL1P6hBzLsLNP0hNL58whe1AeegtxMvgBhA@mail.gmail.com>
Subject: Re: [PATCH] drm/panthor: Allow exporting BOs with an exclusive VM
To: Igor Torrente <igor.torrente@collabora.com>
Cc: boris.brezillon@collabora.com, steven.price@arm.com, liviu.dudau@arm.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

On Mon, 9 Nov 2026 at 10:57, Igor Torrente <igor.torrente@collabora.com> wrote:
> Panthor currently does not allow exporting BOs with an exclusive VM.
> However, VDRM (native context) drivers export BOs for import by the guest
> VM, which does not attempt to bind them to any GPU VM.
>
> Allow these BOs to be exported and rely on
> panthor_vm_prepare_map_op_ctx() to reject attempts to bind them to a
> different GPU VM.

I'm having a little trouble parsing this.

Is the problem that:
- the guest requests allocation of a BO with exclusive_vm_root_gem = guest_vm
- the host passes that allocation through
- the host exports a dmabuf from the allocation (which fails)
- the host imports a dmabuf from the allocation (?)
- the guest requests the BO be attached to guest_vm

i.e. is the problem that some host implementations (virglrenderer)
handle BO allocation exclusively via an export/import interface?

If that is the problem, it seems like it would be cleaner to have the
host implementation strip the exclusive VM ID from the request, until
they can be fixed to not require the export/import dance.

Cheers,
Daniel
