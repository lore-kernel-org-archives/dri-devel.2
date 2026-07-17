Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A76C4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E7A810E0E6;
	Fri, 17 Jul 2026 12:30:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="Au0kuC3f";
	dkim-atps=neutral
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com
 [91.218.175.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BFCB10E0E6
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 12:30:27 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1784291424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1QSHXywn4I6FhGv21LTgB+HqCHPxJwx8a+ayIgPrR1E=;
 b=Au0kuC3fj4oAuqSoO8tn7/uoMBJ5LHQLoaq0VnbQjpYZgh89b0kCqMjiKgOGhFeXSkUEd1
 B8SVvdsU7g1NTdvPyYCK0jDN84EJyDuTAAL71gknSh7zqy2ot3/WrSyoq04JqXeMhoyZ6k
 njmTO7+AD1akk8I4+Wfq+YrEyA2UoWM=
From: Junjie Cao <junjie.cao@linux.dev>
To: lee@kernel.org,
	danielt@kernel.org,
	jingoohan1@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 linux-kernel@vger.kernel.org, mitltlatltl@gmail.com
Subject: Re: [PATCH 1/2] backlight: aw99706: Fix DT property names to match
 binding
Date: Fri, 17 Jul 2026 05:30:11 -0700
Message-ID: <20260717123011.442600-1-junjie.cao@linux.dev>
In-Reply-To: <20260701133918.33487-1-junjie.cao@linux.dev>
References: <20260701133918.33487-1-junjie.cao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

Gentle ping on these.

Thanks,
Junjie
