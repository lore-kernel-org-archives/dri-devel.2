Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF47BC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 17:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B90F10E1E6;
	Mon,  6 Jul 2026 17:28:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="gQ8FxNxp";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DB1710E1E6
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 17:28:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783358887; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UFQT4vKlTY4M4sLvec99l+VPvueo+mMFk5L3tLjV8+8LIpf0KPTXu/wrhQGWbJg/2U2DfNz8lW8koAOPYlO0UN/o4M4GznF4e6jxACqurdAt/tVn+viO6WcLZ5Iz7vm6dVHUUO//URWc4rvd3C3UPniZv5BaaNkfNdRYO0qdI/M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783358887;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=9A3HD9iuR84TLtsI+YpUnK/953NwVKjLsAfJ7KhCSw8=; 
 b=TkER0+1T5QlSb/r6n9iCgnLvGWCp9U/1u3j9mukMUl45x095OCEE4+sKmaxCD7MtTXwZ42VkRw2Z8IoWzFilzp9b5nKWFHdzYSP42RbcIsQ8dmfbbtyl8X2IP665IxAIxtS5djfkKVzRzZmvzMHNHIQA1IYEzAtTOAiu/3TeKnY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783358887; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Date:Date:Message-Id:Message-Id:Reply-To;
 bh=9A3HD9iuR84TLtsI+YpUnK/953NwVKjLsAfJ7KhCSw8=;
 b=gQ8FxNxpQZRI4Tvg6Nt3efV7dqlGoJOxYM3VkSLBpaB62gOUReRZx/GyZDAlImQ1
 MOmyIQPasNA+rSCvaawdfZaQ6oskcnVBwrLF00XEAAaKsjDfRb6REvGVVXpXyxH0S4u
 M93/uicgYJElT1gACfHvWaha0gk39zG9FA69aZo4=
Received: by mx.zohomail.com with SMTPS id 178335888556122.52316639311084;
 Mon, 6 Jul 2026 10:28:05 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 2/3] drm/panthor: Add vm_bind region with kbo range
 overlap check
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
To: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Heiko Stuebner <heiko@sntech.de>, Grant Likely <grant.likely@linaro.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260704-vm_bind_checks-v4-2-4705b6ca9f8a@collabora.com>
References: <20260704-vm_bind_checks-v4-0-4705b6ca9f8a@collabora.com>
 <20260704-vm_bind_checks-v4-2-4705b6ca9f8a@collabora.com>
Date: Mon, 06 Jul 2026 18:27:57 +0100
Message-Id: <178335887799.2142747.3877806754337221788.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=24BrRErJxhI0OftvbUgaS45pr+/PlIcnoKeXwbNdw7Q=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqS+Wh3UwseXnVypVGCIoJmAj8b5710vr9Eo+Ae
 k7MA8WX85CJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCakvloQAKCRAOJn5M7lND
 PZP/C/9Y1RCrODyZo+rNmXwuNREVBv+8mzP1aZB/3ccawpB1tf7SQBej1fV+uSgvuJnpXL1tM9/
 PGn1K4u3mzR9G8UnKmQ9gzivLjDRkwFGefF3oSi/7S9sT9pM4foBvMXWSj7gSc64x9VjdFvl4RK
 5di8b3ZFd3py6SehBJHMP71RQooGRKaQN/y/5q4eOWvMeTpJNAKFsiRofpT8g/mRuZSj3qnyHYo
 yojHARMU2Krdqq2gB++e6vyAAPcUp9gbcDwOEGgZUH1JxD9xpjmXJEGLNVT61Lgu1c8HHLYcKB7
 3EwEwaKYeUbdS/u8zDM+TqDhhpZHQCBiLKXMOnipdYcksgbPUq/jkH2MEQmgR4sSzpGlZLohjBL
 2huf2RMwKqnQ8u2lL+oeTy9Bvwt3Mp/cc60uNzv4AOEk3NeATFpP5Nu2X6m6692YPX4VaNrGvBD
 234UxaeI62+8hmAGCRkSAkmLqh0dr9okT2MfG18ic1rTf+1aWoo7jbs4cw4124RJ7Iz+8=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

On Sat, 04 Jul 2026 05:46:45 +0100, Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> When a VM is created, caller has to specify the range of the address space
> carve-out set aside for mapping kernel BO's. That means vm_bind mappings of
> UM-exposed BO's should not intersect with that region, but at the moment
> we're not checking this.
> 
> At first, I thought of giving these values to drm_gpuvm_init() through its
> reserve_{offset, range} arguments, but it turns out that is meant for VM
> address spans that are not managed through the usual drm_gpuvm split/merge
> circuit, so storing the end of the user VA range at VM creation time and
> doing a quick check in the vm_bind ioctl path was the simplest workaround.
> 
> Fixes: tag and reference the relevant sparse binding support commit.

Just realised this was a placeholder I left before I went looking for the
right commit hash for the following tag. Seems that checkpatch.pl wouldn't
catch it either.

-- 
Adrián Larumbe <adrian.larumbe@collabora.com>
