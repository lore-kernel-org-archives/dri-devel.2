Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D857606A32F
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=mT7pcXVj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FB4D10E1E9;
	Tue, 17 Nov 2026 16:43:44 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9DA510E4E7
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:39:56 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-8b30cbfa628so37046187b3.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 05:39:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794922795; cv=none;
 d=google.com; s=arc-20260327;
 b=HJVpte4QBpr0X5CKJUWV6QlloWVFzBG65Xdod6BoSZdF3m4T26X94n96khVypek9In
 3HkpfHgRmYPZ2cFO7brOW3N/pVu/vOxFkF4qdTr4oaytLRY/DuBkV+ptCTcguWl8Hg63
 Q/NzeFNP7yfSNMLkeTihEjeR0MM36GmMG2qqCDKuxT4iZyEhWIvzLg30uSyepIH1Fe1T
 2wWli26Wit3mKwGzH6MMduf5b/07w6qJ/CTJ7A5EQzwcNGpGCwLR2lePWATVdqwfCL8l
 G7iiIdQXnzbXa5ktoC+mN6k7WrfNDeAngTwltgSEuN03aGde8gYwEF3fv8s+mKhlJSCh
 gXrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XEzhtKNrfCwbhrVqfalLIfid6v0x/h6uA3CCCETLY9s=;
 fh=pxlLrVIc4sLR4KAm4EuYBq13sgawtemFVd5Eqtdoh2c=;
 b=Z12iwjUjxuFeCRScr0IHYBH/1MXx4nE07Ci81WhffWtwWgrJlu+RGUG5E+aNCyJJew
 av/8hmDirze7N7GmmlRrlUgfvzF2M6zZBcyFsQOC7zwiPtGWmXvMIkzHZxi+VpbMHEgK
 i3kIokYey8EQyV76x5AuaeXWZImIvVdD3HHS87WATDEhTBfzQLRtgFUdZd2pO4mLZU1I
 6P43o8Ifv+g2dVXY3JRP5qaXMOUKJlK/jmC5NoVteI47ky4QdrovD4HlXMI586ZRyvtk
 kosglroYjf1aER2BktEop53MJMpIM/ecWT7AXU+uStoAJdBU5Z9hzmzd77sqKFR5LstU
 ADKg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794922795; x=1795527595;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XEzhtKNrfCwbhrVqfalLIfid6v0x/h6uA3CCCETLY9s=;
 b=mT7pcXVjBhYNU4NUTpOnYJbiDsNAsDK8AybIZxOU6RiulZl3rWLfMkdSd3DY/DVlT0
 yLSYtbytgu4dMIu0Om8UnUPQmTU/Yr2hdo01ItTCo0ShGT8khL96CpmrifVQBdAoo1W1
 mZ2ACvLrUKT8IZ57pmE38wJklft2UTVGUKZiGAPFw0d+aFPH0hmIy5C6I76+B+qW2Nyz
 dwzWv/iDW7fWqPNyKxiVnGRmLff2y3gc5lfBVtBPz8Zay9grhwO7WO2QOOWlf0ZuNich
 xLGAPl4DkdwXDEIWqgaKz0EyWUSn2btz7P74Th738khQH4WcXbgbaVNj8AIOgUVq5g82
 dFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794922795; x=1795527595;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XEzhtKNrfCwbhrVqfalLIfid6v0x/h6uA3CCCETLY9s=;
 b=izmJfOYOYaaL33sKTbA+dfIZzUd3dvga3Wv2F4LFt2EgA9evD9HyhwxrS8Havjs5yj
 CSodR56LRASFvrgnfX3EOWh+FdS3BEZE8sFAnwHZNMSEs+BCL5qBxjaF9j0m200s1kaE
 sbmTPK4Dx1ot5JQJXQLu026O0/h74nuX5d6yVVhkNaDjDV4j5fxK08T7nfZ760YgGXd1
 G12bYix5OWZXbqPd2m2fWKEqrzEIufE7BiIPYiNt3ALy/46671LYdnkd9kznDb3lfeyG
 HhUwtzmcML0E4jrB02t33yeZL0+0HQxpPDqmrjgYoz8v2+uqA/OH15VlTQxZ0SoJECT0
 5pFA==
X-Forwarded-Encrypted: i=1;
 AL+hErFejNq9CSScQCSB0IzMlc16oqX7ZAwgp+Az/jqM809CmTjQ9es+JahxUHnNO+T4HREQblMAJmv6DBo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/L9RXQ3zpuNcB8LbPpCzjeF7BeZyt8fa21GwwizsepHij/Lzmk
 zua0s4bTJ4nuPn/o0pfZdteZP8rLvmdxxdUiY/VQV7eriEgq9TRjNowf+bBofgDpSxzIeNV9gr9
 Wc1WGEHtx4Y5NE8Ebe/48ikKYn6eEDmzZYuJ2nxGxAw==
X-Gm-Gg: AZFdTZdK89Zh8e4/bhREeaM6H/zmZ9hWVdVTGtgjmD6tVGILd4Rw5vd2ZOe+9cOyO2b
 5YmVH39Prl90jQdnET+OJ4GUoyadTXIc2kPN9XQMLlAyq7rUGzX0rXvQ8hA2i5uLVJMmE7rWXd3
 /7Za0xla97X87sgSOLNBPUGy9Lu/fW7nDVnPQslAZ3PXiP3itXjoqOK7K2i17wcjRQUGthuJ/SP
 qavAFaUyByMD1TRwPcUwPYf+oB+l4yUmBN7VnPxsuiGVV7n5UvMAJZjibbayNbQsvQOkJH34ODa
 ZC+jJizVz/0yDRs0c64ILwjT0ZJ7Yg/SiDggIGuL79g97RSoFknD9rt77m+8/LoexvoV9CvdHIE
 4Le1l9fgCyVOS9IbUpcj/gryYNAxEArCGLkBYP7CfJ74uTvS+MFVuwtbYNxdCZmu9lkLsUQ==
X-Received: by 2002:a05:690c:7487:b0:8b4:e258:408 with SMTP id
 00721157ae682-8b4e25815d4mr25624007b3.58.1794922795328; Tue, 17 Nov 2026
 05:39:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260301090411.171060-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260301090411.171060-1-alok.a.tiwari@oracle.com>
From: Daniel Drake <ddrake@baylibre.com>
Date: Tue, 17 Nov 2026 13:39:18 +0000
X-Gm-Features: AclHuK-xJBKk8oIlagpZz9dMYDJfPzx0wYA0Je59VMlIM_ymfYG-hgnFUEOhHWY
Message-ID: <CAPGwodorzbF3YnCmdaPhK9JG+a1ioPda=qnh+r8H5JtigFQAQA@mail.gmail.com>
Subject: Re: [PATCH] accel/ethosu propagate devm_drm_dev_alloc() error code
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: robh@kernel.org, tomeu@tomeuvizoso.net, ogabbay@kernel.org, 
 tzimmermann@suse.de, Frank.Li@nxp.com, dri-devel@lists.freedesktop.org, 
 alok.a.tiwarilinux@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 17 Nov 2026 16:43:43 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 at 13:35, Alok Tiwari <alok.a.tiwari@oracle.com> wrote:
>
> devm_drm_dev_alloc() returns an ERR_PTR() on failure. Use PTR_ERR() rather
> than always returning -ENOMEM so the probe path propagates the real error
> code such as -ENOMEM, -EINVAL, and -ENODEV.
>
> Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Daniel Drake <ddrake@baylibre.com>
