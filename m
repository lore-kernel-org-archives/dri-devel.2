Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551A2CD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 12:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 735FA10F121;
	Thu, 28 May 2026 12:42:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="GHsVZzXZ";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C6A710F121
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 12:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=eqfs4KK63S0TOSE6+RLu6s71mPduUVA0LxwjeQ2pykI=; b=G
 HsVZzXZP50EnuqFQuNvCHI6wfii4vWJ4d7KHSxs48eUIZPyebzqW4Lgq4v9Bch5P
 2UZk9RAZiY1NA8/ZEsZVYV32CsHmjMDBgVLJbwf76fSQRk8Z6wAASFLbJmovgZIM
 9/VXNvA0/xCFgxRDEQwxvOMbAnKCNojagTnpAXz+WM=
Received: from w15303746062$163.com ( [113.200.174.80] ) by
 ajax-webmail-wmsvr-40-149 (Coremail) ; Thu, 28 May 2026 20:40:44 +0800
 (CST)
X-Originating-IP: [113.200.174.80]
Date: Thu, 28 May 2026 20:40:44 +0800 (CST)
From: w15303746062  <w15303746062@163.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 sumit.semwal@linaro.org, jeffy.chen@rock-chips.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 "Mingyu Wang" <25181214217@stu.xidian.edu.cn>, stable@vger.kernel.org
Subject: Re:Re: [PATCH] drm/prime: Fix unsupervised rb_tree corruption in
 drm_prime_remove_buf_handle
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <0e12ce28-f5b7-4ffa-849c-df9ad1796e22@amd.com>
References: <20260528082912.1051262-1-w15303746062@163.com>
 <0e12ce28-f5b7-4ffa-849c-df9ad1796e22@amd.com>
X-NTES-SC: AL_Qu2cC/WcvUgv4iabZukfmU0Qguw9Xcq5uPkj34FWN5t8jCLr2iAKW0JFIHb04eyMFRyerjiMcBZ1+ONjdJh8W6EFDzOAp66oJV0VScdoN1osUg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6d351ca7.9904.19e6e99f765.Coremail.w15303746062@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: lSgvCgDX3qLNNxhqaMytAA--.11951W
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbDAA2hhWoYN80SlAAA3n
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
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

SGkgQ2hyaXN0aWFuLAoKVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3IGFuZCBmb3IgY2F0Y2hpbmcg
dGhpcy4gWW91IGFyZSBhYnNvbHV0ZWx5IHJpZ2h0LCBhbmQgbXkgYW5hbHlzaXMgd2FzIGZsYXdl
ZC4gQWRkaW5nIHRoZSBsb2NrIGluc2lkZSBgZHJtX3ByaW1lX3JlbW92ZV9idWZfaGFuZGxlYCB3
b3VsZCBpbmRlZWQgY2F1c2UgYSByZWN1cnNpdmUgZGVhZGxvY2suCgpUaGUgc3l6a2FsbGVyIGNy
YXNoIHdhcyBvcmlnaW5hbGx5IHRyaWdnZXJlZCBvbiB0aGUgdjYuMTgga2VybmVsLiBXaGVuIGlu
dmVzdGlnYXRpbmcsIEkgY2hlY2tlZCB0aGUgbGF0ZXN0IG1haW5saW5lIHNvdXJjZSBmb3IgYGRy
bV9wcmltZV9yZW1vdmVfYnVmX2hhbmRsZWAgaXRzZWxmLiBTaW5jZSBJIGRpZG4ndCBzZWUgYW55
IHN5bmNocm9uaXphdGlvbiBjaGFuZ2VzIHdpdGhpbiB0aGF0IHNwZWNpZmljIGZ1bmN0aW9uLCBJ
IGluY29ycmVjdGx5IGFzc3VtZWQgdGhlIGNvbmN1cnJlbmN5IGlzc3VlIHdhcyBzdGlsbCBjb21w
bGV0ZWx5IHVuaGFuZGxlZCwgZmFpbGluZyB0byBub3RpY2UgdGhhdCB0aGUgdXBzdHJlYW0gdHJl
ZSBwcm9wZXJseSBob2xkcyB0aGUgbG9jayBpbiB0aGUgY2FsbGVyIChgZHJtX2dlbV9vYmplY3Rf
cmVsZWFzZV9oYW5kbGVgKS4KCkkgd2lsbCBkaXZlIGRlZXBlciBpbnRvIHRoZSBjb2RlIHRvIHNl
ZSBpZiB0aGVyZSBpcyBzdGlsbCBhbnkgaGlkZGVuIHJhY2UgY29uZGl0aW9uIHVuZGVyIHRoZSBj
dXJyZW50IGxvY2tpbmcgc2NoZW1lLCBvciBpZiB0aGlzIGlzIHN0cmljdGx5IGEgbGVnYWN5IGlz
c3VlIHRoYXQgbWlnaHQgb25seSByZXF1aXJlIGEgc3RhYmxlLXRyZWUgYmFja3BvcnQuIElmIGEg
Zml4IGlzIHN0aWxsIHdhcnJhbnRlZCwgSSB3aWxsIHNlbmQgYSB2MiBwYXRjaC4KClRoYW5rcyBh
Z2FpbiBmb3IgeW91ciB0aW1lIGFuZCBndWlkYW5jZSEKCkJlc3QgcmVnYXJkcywKTWluZ3l1IFdh
bmc=
