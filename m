Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF87CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D2DD11281A;
	Fri, 16 Oct 2026 13:55:17 +0000 (UTC)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8A0110E21A
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 13:54:44 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a01b112fa2so44139725e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792158883; x=1792763683;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=o1zW8ObmJUqyJoTK7Wl6HPlLn7nz+xpXE4cGz+lwfMk=;
 b=i17+1i/PJ527NtgJhSg3YMNDJEQDN6u2FIL8AiWLwqjmX7VFo4G3h4sFmKFNNO2naA
 wR6KbEhA1wDcYN7CZi3Ti2SvpyCNqp1MKXcz8/Nazqz/wIKoAJBTnBVO8duj/+aqlKHI
 OCYW6IKw+ujR6iJeGk7DTACK62bQQ2QH5hff7/rzYi6EkwfjKpUWSnDwYa7pdn7Q5/hR
 yTiJ332pAQ7VZsMMaZPLJNjuxR5PhBCp4MPajEoOW7oNMFDr58+dXy62tYcgLAyHUHev
 mZXKevRA0grlyEHqdThLW1MluJGtMy++6puA/yMSuIdyTSkG8fgBSAxywgoNG26tLYJc
 sRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792158883; x=1792763683;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o1zW8ObmJUqyJoTK7Wl6HPlLn7nz+xpXE4cGz+lwfMk=;
 b=jfOVmVPnZms1rCSWUnM8nC0TRyDiv1Jv9h3EILuX04skaRN17wlr/bdO9JZJaXDucH
 +pn2Bs6cxndXOvQxeRAFhSU20j3CQGnlWx1pizdFXx7l26rkvA76EWjhBl/p2v5bEDPA
 VmbDwtpdIheFGtHZGugo8DFis7N8sGJoLVjyVyXdYafmT1E+O7y9g9kRCWwnW9qNfzvi
 4fCZS6KJch3Xx7921Kwx5srFTXiBgSbdx+YAYreQUXApsdSMpqsP271e220m1dtzhpWE
 UIZ9sYUxV8WcoENrvysqtdvRCVsopneSAbujEN0iAeBWvlX4+oe20mcQb/6ZbTN3Duzu
 RC1w==
X-Forwarded-Encrypted: i=1;
 AKwUvBypABiWNV6kQDJMJLiAptEBJ2Efgule9Th+Y/ODaQGpPkjcDjcqcvdW4zBceiVkfKUdQR04aEEZoqA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK3FpQYAj9CnUZ7XwZZnNUqkctL67aqhXfBn4h/vPUva4Vn3T6N
 YSMg7tWLsPIIuccaZthIVIaWaLpCFz4kDFHZP0nQAsja3xuqUFEuDxjeC+laGVe3pYqYfEn5mvn
 SouWko7vyRLojy96v1g==
X-Received: from wrwq7.prod.google.com ([2002:a5d:5747:0:b0:48c:7482:b673])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8216:b0:49d:34:420d with SMTP id
 5b1f17b1804b1-4a18e4b0465mr464383285e9.20.1792158883019; 
 Fri, 16 Oct 2026 06:54:43 -0700 (PDT)
Date: Fri, 16 Oct 2026 13:54:35 +0000
In-Reply-To: <20260814230923.1292966-4-dakr@kernel.org>
Mime-Version: 1.0
References: <20260814230923.1292966-1-dakr@kernel.org>
 <20260814230923.1292966-4-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016135439.44716-3-aliceryhl@google.com>
Subject: Re: [PATCH 3/7] rust: drm: move file_operations from gem to device
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, acourbot@nvidia.com,
 daniel.almeida@collabora.com, 
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
 tmgross@umich.edu, tamird@kernel.org, work@onurozkan.dev, brauner@kernel.org, 
 lyude@redhat.com, j@jananu.net, alvin.sun@linux.dev, 
 deborah.brouwer@collabora.com, laura.nao@collabora.com, 
 beata.michalska@arm.com, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Sat, Aug 15, 2026 at 01:09:01AM +0200, Danilo Krummrich wrote:
> Move the file_operations definition from drm::gem::create_fops() into
> UnregisteredDevice in drm::device. This is the file_operations of the
> DRM minor device, set through the drm_driver struct. It is not specific
> to GEM.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
