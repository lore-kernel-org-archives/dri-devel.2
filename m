Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C563C982C1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42CC110E8BE;
	Thu, 17 Sep 2026 07:05:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="hRpLQ70o";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="uwcN4+Ps";
	dkim-atps=neutral
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D2D610E8C0;
 Wed, 16 Sep 2026 08:22:37 +0000 (UTC)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 70FD514001FE;
 Wed, 16 Sep 2026 04:22:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Wed, 16 Sep 2026 04:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to; s=fm1; t=1789546956; x=1789633356; bh=RjjXMwO3RBHhN10FlHwFS
 JNkrOjydygpbSv33I0kjNg=; b=hRpLQ70oc3RG9dD0nXCXmAEiDbJhGfJYT46oz
 MX5gtetl0J1wtwOeCaUGgtqL9dVqntxYNEVRnUdP4cVxvvfYvdOMd5hoAEYDKmcR
 lus2bh9/CCqbMF/aP1msNoh3VCE3b78DzuEIk0cgnP76LBYJkGsXRI7Uyf6DCc9h
 19pQCpgRwhtZrwgj0aPVAOX3bvjcsDILVBfLP6McetE4EwNgGW2lH+u8VQQbOViv
 1jarod7ODO0ZT+rmQjbxwssTQUTCgDGuPkAojUEjyWUsx4i1KcG3kFMhxRvkrHbc
 ynBQOZO65UhCyZPQhvuei5J+L5C8UfXuAXXfQT7AEjSqGHlLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1789546956; x=1789633356; bh=R
 jjXMwO3RBHhN10FlHwFSJNkrOjydygpbSv33I0kjNg=; b=uwcN4+PsaRMWo8t2Z
 O70Mjgh2qaXZUiybtF0blAVa8KIINka9xa0ejJUhGiw3oFCP3eVxZJr78qx/0sS6
 DkAAeesMIAnex1U0cn6UiNCNvmc9v2aglaOIPEESQoXGf3fYaxQynG0ZsogXOJQ2
 tu3ztAaqWj0vq0cTmvHX9dmqD8lFF4T2JP+mATnhL+JFULagW6nOZtOuktChvIyG
 IF3oO7FcjTCdO+8e/XuaIE0Uu81MlSf7bvsNBTIleLeTsj4GFHuaQoaN/tfvE4Af
 LQUwZcOUK323mvn+tmBex/eZerBlqRz3tCmZ+dhOkPuofviCe3zRyDvyq1CsoRc2
 cJD+A==
X-ME-Sender: <xms:zFGqamj3l-85ka1StKLz9Wg9kYHaC4CmPjSZmts4vqkwcYp53J4hHQ>
 <xme:zFGqapmnjwJxbzBmX_hBFILiVtmclH0JE45jjVOn3A395JQnF1C19_BVTrNOR8cNR
 mLj1WHnFVqt3R5G5CNV5DjmkIeBtXXRHmpSsg2zWv3bvKk7gkE>
X-ME-Received: <xmr:zFGqahun590ZEzDD7fSCs58lj4KxfPJVWyQ2j5RYntCnxQVDUihMPdNrk4uvFkhRu5DWLDWGxEZu>
X-ME-Proxy-Cause: dmFkZTFjALIVprZhtt7ZqpzfHXxszJynVq6cy3cumQYNy92JwiWl76o59hd46DRSJCK7bs
 fDy7agiGOpVisM7lAwV7WTJtVJ776e1E9d/3WI0PxwufSF+YSQrjB/Jqtq5DbSwa/nWkf3
 xnUMgCvJMBfyp7auhPYv97TsOsT6SXZcrNrXuS/nhfU/8Q4674cUiHvsu+v2s1SqPNRdyw
 xytLlIZufebWPN0F+nkTz9U3xB+zVYB0b1k61J//8NoC5yfkEiH6pQEQWQayBb2MpohjRE
 t5ZmWM7pbfV55pXX0I8Q+s8COmIvcH7koD7eaYedl9dFhW9fatu1xmO5QpYUI7++r4jReK
 8ut51Bj0QpuuOHQryLvRxPfW4/Kk7+JtySRT9UbeNiOS57Z4YHO+XccTjRgaVWM1oSV30v
 EkBzPrIcMcP88qeMXH0DOuhye16V4onZLqJQ3VZopA9XYPyK9pELgyr01IwQ+DAnTCxZ41
 JOmoEf2xnrE9lLmfYwgTyudoBcc8HbN3sXeasUMe7vInrstrfBoN7OMHGxDnJpYLxUlGPF
 bo2LX5krukBngQ9BIqdpBJSV2yG7IJtjjOJNTKy+hAc0qqDtOXzACmtnroEzALSou9g2ao
 QZJewunSl1ucy3nBlK1jRdufSfjTYGdv+CASmdzLL3YpfhK4zseIWyW3bWcQ
X-ME-Proxy: <xmx:zFGqavYdNSCXeJNvejqXD6joi-tQjBUPI2NlXsfC7qc6YVlRcCMBrw>
 <xmx:zFGqapD10ONosXyv7OdVuf80fQ4X0mAGl8PKkHTYu_u7ZMFKSzuSYg>
 <xmx:zFGqan-k-Q42LqM8F7xMxQSe0AV_Bm5nxJ3rUAc-h6ubJvSKvewhPw>
 <xmx:zFGqalQgMDoOIilOzaEBnRAW-p83GciKDuQ_mHRCcOuHjfPkIatr9w>
 <xmx:zFGqapUv7mNnHXl29R3cT22Nx5-dM8nDNyRvWCxwQeDIVDb1GYwgHc6Y>
Feedback-ID: i792e4853:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 04:22:32 -0400 (EDT)
From: =?UTF-8?q?Szymon=20Aceda=C5=84ski?= <accek@invisiblethingslab.com>
To: intel-xe@lists.freedesktop.org
Cc: lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com, matthew.brost@intel.com,
 maarten.lankhorst@linux.intel.com, marmarek@invisiblethingslab.com,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/xe: Limit sg segment size to PAGE_SIZE on Xen PV
Date: Wed, 16 Sep 2026 10:22:22 +0200
Message-ID: <20260916082222.2650308-1-accek@invisiblethingslab.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820101212.1608543-1-accek@invisiblethingslab.com>
References: <20260820101212.1608543-1-accek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 07:04:01 +0000
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

Gentle ping.

Maybe this was missed, because it's my first patch here and
patchwork reports that I'm not in the allowlist for CI.

  https://patchwork.freedesktop.org/series/172525/

Could someone trigger a retest (and ideally add accek@invisiblethingslab.com
to the allowlist)? Happy to resend or rebase if preferred.

This fixes xe being unusable as a Xen PV dom0 GPU driver (display
corruption, GuC job timeouts and eventual swiotlb exhaustion) --
https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8382.

It's the Qubes OS on Lunar Lake issue Maarten was looking into in June.

Thanks,
Szymon
