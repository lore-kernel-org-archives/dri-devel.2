Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EB0CA5FFA
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89F5A10EAEE;
	Sun,  4 Oct 2026 17:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OsNQ0Bc9";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 787F510FA39
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 20:48:32 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a02726f225so41525e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 13:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790974111; x=1791578911; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Xn8v821wbWVD9E8elR4jk6DR05TUKT+raE3vBfYoiWk=;
 b=OsNQ0Bc9KSV4FOlD11iEb7A8HDozFP2X0NSDxhL2889SE4fj0Ws5OTdKguhGsG/NoC
 +AFG19yw8ar5OgGb1TfR4u2Wgfx/n1aYi6IbxzDjUpLu9RxRl4o7bKSI2nPTfuOfSraj
 O54Eml7TH8X+L99FmFLFSKMMNrIM+yu2aIaYAOyiM08O7BCsjDiD2bE79ZlkGYixmiKN
 f2mCRMVofllnSsasFUha6wcDzoa33A7wr8Fv1YKlzsiLkTpCCEiVieIAM9275zVILA4W
 N68ZMCRf5mt2nBXLnc4vuBHDr9uvCzJdZkL0lRtAv2N3yaWOCz8/JHg+yEL9RQ0i3S7H
 wMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790974111; x=1791578911;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xn8v821wbWVD9E8elR4jk6DR05TUKT+raE3vBfYoiWk=;
 b=XMpBclZWnjbChUOlgv+d0L9h87IBzK9BQSpJCyDyI5AHmILTd5LRtJnpCQbRczmKJn
 iBasLFOLIGeofMpGmCD2FyYWSBN2joq8GPden/5muqGF25WKMjgQyMAUh1qSiB/1y8ed
 6Fmr3diaAYWBsDNHBeGNL/CNsX/5CgJsH42EC6sY3u/eDDls387cz8veTH1Wi/OSzV+t
 I+NiNFH6MEwjeKrQ+5dSkW8GRNO5tqKDy/OahkbqPC9SWQkaRobjllGHrY2In31Pj56y
 YkCjEmCMYVt5Wsl8QOJTMvf0R8g4Ya5VLplbqrLWvLfj4O2QWHu68bMzHER4bL5pmWUm
 TGCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSzw9gIXgO6aBTVlWFtaP0zfD9k3BI0IOfEtIyo+v+QyCYEBOoTogNzg3paN9pViLHXn5r1lJc9VY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mgmIhfK8SMcKkqWHw7tC44aECkbrkaL+TQHhToHsDPqlhFKi10
 m+44yZD2h3GGXDzTos8zEyv1ED/paivZ4yWJx1lKg3gUi/EIJ8W83iMa
X-Gm-Gg: AYBFou3R+MDH9iVkbGe74C3lb5ltIkASc0fYw73ojs3IwkT6QsWfIY0sT2vGwuX4fnY
 uIQ6U8Rg3T8lY/5IFT0EXo0Mg8lG70MUm0X8hyiwxh17+00nWXgWTmBDQDWv3FGpS+ZQhX7rPhU
 Mt4NbFndhZKEDXW7pntUVkS1+KY5NpljVtA+qaKwUOBZKinlZI3ivVTV0eAmjITyC7yAcoqibc/
 Z7w9tM5HrHxrdd8K4sI5CpdXIbhYwBZPD6bFOysODpXliCf3VSJ6uIX1cTYE47/bT6wiwInqT7W
 M8ZetolC/Ery02VvrCvdJAB74XA0BcWkt4Qbp5VBmH9jIm4RkM8fX+ii6a9EqPNNLiftUslFeCO
 1XiGltm++wq7PWBdYzVjP+ZtwENvIP9A4FO0JYD8tb6Cl82Uf+4xI4owmzQC9tJ5kEd7QQL6tXD
 fsOoqtx9g0uLgtq1JxYmZ280ntJjoW1+ORtaBjL9HN5l+j+3jmBYDOgxpIe0JoJ/1Jr0ILVSyn9
 HNy0xkGDxTgbAlCbnPnWKwso5kHlFJqBA==
X-Received: by 2002:a05:600c:609a:b0:4a0:1c98:de52 with SMTP id
 5b1f17b1804b1-4a02755c4d1mr65627725e9.1.1790974110562; 
 Fri, 02 Oct 2026 13:48:30 -0700 (PDT)
Received: from Nuel20.localdomain ([105.118.71.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03ff3cab2sm39343925e9.2.2026.10.02.13.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 13:48:29 -0700 (PDT)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, alexander.deucher@amd.com, airlied@gmail.com,
 simona@ffwll.ch, skhan@linuxfoundation.org,
 Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix kernel-doc warnings for cgs register
 typedefs
Date: Fri,  2 Oct 2026 21:46:40 +0100
Message-ID: <20261002204803.27695-1-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <981f01e1-0c3b-4854-9d72-8bf22af9fc64@amd.com>
References: <981f01e1-0c3b-4854-9d72-8bf22af9fc64@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

Hi Christian,

On 10/2/26 13:38, Christian König wrote:
> We should potentially just completely nuke those typedefs since they
> are actually an unnecessarily layer of indirection.

Yes, the cleanup is necessary, but the four comments don't just name the typedefs, they're the only prose describing the operations (MMIO vs indirect access, offset/space/index semantics, return values). Should i relocated onto the struct cgs_ops members or the cgs_read_register macros?

Thanks,
Omokefe
