Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71821C5DF8F
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 07:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2E0310F243;
	Fri, 21 Aug 2026 07:23:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a4GsrilI";
	dkim-atps=neutral
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CE1110E23E
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 02:26:53 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-92ed19f4d60so28412685a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 19:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787279212; x=1787884012; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3p22lcB0JjWSZ69s6Uy8khUw1NryKg+QOA+ussz8obI=;
 b=a4GsrilIt/4P1XguxEM+YqrECrIakm+iIs9ncp0I/07HCPtsMxflV6m3ebam6y7NAH
 Cpm+SsECW9geLZPHO2S3ncQTqlahWcQPIorzt9AFlVLXOsSLZ7DwjXr/UKhGr1IXEZJT
 K4SSYmAaYAkQRlJ3IHsjD2CjPuiyjpD8Ks6E5DOcFCNGvPB4VUZ2hTKfMXVNPyzv2Id2
 5ioT6cdRz1cmkvQaQaPTjsSm3ZKpcMwtRO+mIziaFqi/MfPaz034toEDMow8yRlm5qw/
 w2EP8jL9x5BCoZb1Oa03cjeIAIdZj/CSSOqA/SR0uHNiLw0sHdP3KDsOh0dpRXRXATES
 O2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787279212; x=1787884012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3p22lcB0JjWSZ69s6Uy8khUw1NryKg+QOA+ussz8obI=;
 b=iUfPg8Gm26LmfoXuKsvjJRckdBUPG//27glxtp6dJ1/QwctQZZ8M8GTqfogG8v4Cw6
 um0uPzecs9Ot26+VkQ4H3D8H69+cJMLZiwq2NjAIn9dj6XmaZ9TE5iHRt7tj4da8WVcX
 gOKD/XAkwDfUAZ+XMOxsdmJFknt7JEEfa64NrouBj61wnG4qpwp4nDY2k5onI+BW/55F
 PPK41Pj9P7xXi2r1A4iMasi7SqNINF6v4COboqa8/HrwBn8Ic8TldhmRgJx+U1WQxDSd
 Mb/XsEs1vAIZ+S0dsmTczgr/3SfG0oyeGUa/PG7IVw4+2nfxoQvYR8evImHM4szQFUJI
 NIjQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1C7kdCr9PxSYqcXaSrVsEGo7/+Nr+V1iXMBAcWFYmruxSGcf9y6c/ZlNIry6JnvwFy891JfBkek4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxd7E8BYRPy//tpmi85oyIPybv0dHCcWo3Vi321QjDQm55PDQqy
 7fa+ETDxQ1r2+bONnbuPlu8qpp9hb9z0DLgbZNjMBpRjESrhzff1Q6p5
X-Gm-Gg: AR+sD11IYQ8HW+66Qa7ve/g9zHa+0Kwy+DBwfCOMjFgRk1RrIQz26yrskahg43tL0nx
 MDQmPX7QX426eSQfQiHxXxqc2G1VHG5Gh0WM0q2KX2DyiagBkAsRmJctKY6NfhQX8UG06uGfw8D
 2CG5SPZkyjhfttpyqanVzOnsoSwshfKEGsNZOtCG5YIdEHQcapd8gGuyuwWJ02CM/CbEYXYZrGE
 93Lcja+0FUb7p0jxzbywfuIf13qaNdl0HBew/MANFDZtk5qIeKE5qfnEXQcu58Rn6mZT78OZkWb
 X3LirM7jIKudFS5xqPI9f23rwZVOLEhKuwablDgdwsv3sWGxstGBdxqoXlB2Ct82wAm9PUBjZM7
 tqA+SCuR+dRr4Pvgjmqj/TETon1RczbUD8UzxQVntUCBahLzQAJyjtuvRxx/WEWO3o91ORU+cvc
 s9dMLYY+bVUc5PYe/luSlexb0ClaOEepY9iiHo/J57YpplbykYqnJYaiFsQNECzqG9bAaq0SnEz
 vu51xRfV6M4NJchCw==
X-Received: by 2002:a05:620a:800b:b0:936:a8cd:a28a with SMTP id
 af79cd13be357-937285a4fd6mr1143653585a.22.1787279212194; 
 Thu, 20 Aug 2026 19:26:52 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-937204aa8a6sm498714685a.11.2026.08.20.19.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 19:26:51 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: dev@lankhorst.se
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 bigeasy@linutronix.de
Subject: Re: [PATCH v4 7/7] drm/i915/gt: Use signalers_lock to prevent
 starvation of irq_work.
Date: Thu, 20 Aug 2026 22:25:29 -0400
Message-ID: <20260821022530.2503120-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706114823.752313-8-dev@lankhorst.se>
References: <20260706114823.752313-1-dev@lankhorst.se>
 <20260706114823.752313-8-dev@lankhorst.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 07:23:07 +0000
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

Hi Maarten,

While reviewing this series, I noticed an additional request lifetime
issue in signal_irq_work().

The existing RCU loop removes rq from ce->signals and may then call
i915_request_put(rq). If that is the final reference, the request can be
released and its SLAB_TYPESAFE_BY_RCU slot reused before
list_for_each_entry_rcu() advances and reads rq->signal_link.next. The
RCU read-side critical section does not provide a stable reference to the
same request object in this cache.

The v4 conversion to signalers_lock/ce->signal_lock and the
list_first_entry_or_null() loop removes this post-put dereference, so it
also covers this UAF path.

This is independent of the PREEMPT_RT irq_work starvation trigger. I can
reach the sequence in a diagnostic run, although KASAN does not reliably
report it because i915_request uses a SLAB_TYPESAFE_BY_RCU cache.

Since this also removes a request lifetime UAF from the common signaling
path, it may be worth considering the relevant fix for stable kernels once
the series is accepted.

Best,
Shuangpeng
