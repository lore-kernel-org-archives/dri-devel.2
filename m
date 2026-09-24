Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1632BC98326
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A4B110F938;
	Fri, 25 Sep 2026 07:30:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VFiRMOY2";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14A9C10E55A
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 16:26:05 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e721b5503so482415e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790267163; x=1790871963; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TKqbDfmVx8XOcuUP5vdlZRzhi46G+tOuyrF2LCLjHaM=;
 b=VFiRMOY2uafqwrAUsssJw6h9P3MojH2J836++cvqIw0M4S/c8jBa9DUkP9qJdm6WFN
 iMulqwLKeePYku/TsvRBOPrQT3H9fNEo+EV1dtIHWfmLCE8c9MWxGs0C8TtgwEMqKDmS
 pASt557CaPM1TzcjX/cxaaa9W286GHZUZRXz/VsodIXssYWgIEp3I0N/Usk2p0ksEBGi
 t497hbsMasluCFLhHaoDC4hJFmTtZy+13HWjoW6BubrB7/DA2UO6zKnam+plPwO6o8Z4
 Neeb8VCHvMzhFtulaxU3p6nT2ly6StTLK9UKVlxeFAcSUe03ten/05ETosTA8vNtmiwW
 PSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790267163; x=1790871963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TKqbDfmVx8XOcuUP5vdlZRzhi46G+tOuyrF2LCLjHaM=;
 b=VUW2GJfXTn4lcj7vbNpN3Dhxqe7Lv+h8yowxl1GPDDSWZwiB5yejmc/rE9QM7Zb8Mb
 11AlidGwiIXqXsmuubV5+CgCoO5lK5VQUSCBdiVtHDu6hnjN28E4rKRj633JzzdBxFT3
 BnR9d3fiYbiO0fKVcKpTy6W7doT7Kx9wIFBhTEyK8xZTxkM/oeLZFlwvmeligBmhVw+m
 rfUqIG4MzJeYjwwJvgdCXMGtMIuBW7YKwo6yWUv+5bfmfK3jGQPyGXZjcv/UY+xcFn9K
 D0u7Z8uOM6uTama/k9xaMeoZQp8UEmV0ZMwbHQO1BKP7PAsiAdg78UgKHGmPt0uWNw5E
 rpHw==
X-Gm-Message-State: AFuF++kwT/gtfJobDnLP7klTFo8eLiFDyyn8rc1UGfcjd4fpGJ1nj48Z
 9QvJo9KaaeQIeZ07Cv+JswuUudUwVB4WBC4I3NYD9iJcHa329HAlSUbo
X-Gm-Gg: AYBFou2pAnw6/lU252eFGd24Co3/lQgUyVd7MEocnQMWOK3YZqajgadFbxvy81b/phk
 vT2v7VVG9rYMe7LPjOoKFmdCYUUY+tWM3MzPKA+weJ5u6icGOJWzNGQPPYw7hBe1R50esG/WGGc
 82x82+Rw0EYVrw/Oo3u3f+OGGaigU6JPQsMyPX1ehLtE4WryENXDtMELOE2Z58GRFCKjTyy8vwC
 7IEue/ZNSXIkaRk3XMwwLii69vb/h1X+NsqhW13tbfWAp/qQce6S9tZyXlaqhuq3keoQo15xSyE
 yWnJg9hvdZ7Kw0Owb6eUucFbhCJNLYa4bwbTp/CRm43h2R0DEfGHPAw+q8S6igKCmf6rrvdQxuQ
 oLSaszGh4AqijywVcuzfglN74i205E/7n5eANWnhXymIis3krt8iR2cd2CghuWxN3SwellsMG/+
 3WK6egOuYaD58hrRlkKp90v2o0lu3U7BPgEdJUnU9hynJBy9XGOo9Z2R9k+0SN
X-Received: by 2002:a05:600c:34d4:b0:499:79b9:e220 with SMTP id
 5b1f17b1804b1-49fe66d1279mr50023725e9.10.1790267162947; 
 Thu, 24 Sep 2026 09:26:02 -0700 (PDT)
Received: from fedora ([2a02:587:200f:d100:bf67:f785:caad:e278])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe1432362sm86586465e9.1.2026.09.24.09.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 09:26:02 -0700 (PDT)
From: George Karagounis <taterraster@gmail.com>
X-Google-Original-From: George Karagounis <mail@taterr.org>
To: ville.syrjala@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 mail@taterr.org, rodrigo.vivi@intel.com, taterraster@gmail.com,
 tursulin@ursulin.net
Subject: Re: [PATCH] drm/i915/display: Split i845 and i9xx cursor updates into
 arm/noarm
Date: Thu, 24 Sep 2026 19:25:58 +0300
Message-ID: <20260924162559.16680-1-mail@taterr.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <arPeD2dcyUIEGGn3@intel.com>
References: <arPeD2dcyUIEGGn3@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:43 +0000
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

Hi Ville,

Thank you for the detailed explanation. i completely misunderstood
the purpose of the noarm/arm split regarding vblank evasion, and
i missed the interaction with the mailbox updates in the legacy
cursor path.

Given the architectural complexity required to safely split this
without disarming pending updates, I will drop this patch for now 
and leave the TODO in place.

Thanks,
George
