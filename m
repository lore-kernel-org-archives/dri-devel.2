Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2E5606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=a40vdEgc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A61D8112245;
	Thu, 19 Nov 2026 09:59:29 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B6CA112245
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=NfQ/MGBMF5mso9ehm1IpuBGoVkXT11CRpqrZNReIB0A=; b=a
 40vdEgckIDkBAnX1PWsdaqBFIo3gcrthG/4enzuKBJGWaPp+sn6bwCAtdK+DiEZu
 O8U96FEgHMDSqm97eIaZFw1RaqA8TWjjbXt+OAOmuX0TKxnw2gsAddtJdsr/F85J
 +fK54eEhvudDd/WmPlkYoek79LCbdvU450zl1EvWjw=
Date: Thu, 19 Nov 2026 17:58:59 +0800 (CST)
From: "Haoxiang Li" <haoxiang_li2024@163.com>
To: "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>
Cc: airlied@gmail.com, jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 simona@ffwll.ch, tursulin@ursulin.net,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/vma: Fix a memory leak in i915_vma_pin_ww()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <179507544606.16202.12430112951192190652@jlahtine-mobl>
References: <20261118153205.2432736-1-haoxiang_li2024@163.com>
 <179507544606.16202.12430112951192190652@jlahtine-mobl>
X-NTES-SC: AL_Qu2SB/yTvUso7yifYukfmUwSj+s8WsO0vf4i245fO5B+jD3pwgsjZV1FBETJ/viINTi0kjKWXDtK2MdBYZlneJs5YcLmHYKTQ5ooJVcYc/uViw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-ID: <379ef22e.83e7.1a1f33ec62d.Coremail.haoxiang_li2024@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: dCgvCgD3X1RkyP5qO15xAA--.61W
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7QOkE2r+yGM7BQAA3Y
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

CkF0IDIwMjYtMTEtMTkgMTY6MDQ6MDYsICJKb29uYXMgTGFodGluZW4iIDxqb29uYXMubGFodGlu
ZW5AbGludXguaW50ZWwuY29tPiB3cm90ZToKPgo+WW91IHNlZW0gdG8gYmUgc3BhbW1pbmcgdGhl
IGRpZmZlcmVudCBrZXJuZWwgc3Vic3lzdGVtcyB3aXRoIHBhdGNoZXMgYW5kCj5uZXZlciByZXNw
b25kIHRvIGFueSBmZWVkYmFjaywgc28gaWYgeW91IGNvdWxkIGp1c3Qgc3RvcCBhbmQgZG8gc29t
ZXRoaW5nCj5lbHNlLgo+Cj5SZWdhcmRzLCBKb29uYXMKSGkgSm9vbmFzLAoKSSBoYXZlIGJlZW4g
Zm9sbG93aW5nIHVwIG9uIHJldmlldyBmZWVkYmFjay4gT25lIGV4YW1wbGUgYmVmb3JlIHlvdXIg
cmVwbHkgaXM6Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MTExODEwMjAxMi4yMjUy
MjIxLTEtaGFveGlhbmdfbGkyMDI0QDE2My5jb20vCgpJIHRob3VnaHQgSSBzaG91bGQgbGVhdmUg
c29tZSB0aW1lLCBzdWNoIGFzIDI0IGhvdXJzLCBiZXR3ZWVuIHBvc3RpbmdzLCBzbyBJIG5vdCBz
ZW50CnRob3NlIHJldmlzaW9ucyBpbW1lZGlhdGVseS4gSSdsbCB0YWtlIHlvdXIgYWR2aWNlIGFu
ZCBzdG9wLCBmb2N1c2luZyBvbiBhZGRyZXNzaW5nCnRoZSBmZWVkYmFjayBvbiBteSBleGlzdGlu
ZyBwYXRjaGVzIGJlZm9yZSBzdWJtaXR0aW5nIG5ldyBvbmVzLgoKUmVnYXJkcywKSGFveGlhbmcg
TGk=
