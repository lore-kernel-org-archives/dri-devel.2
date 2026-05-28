Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EDCCD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 13:51:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 836CA10F1DF;
	Thu, 28 May 2026 13:51:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="Ed7QzX0u";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55D0210F1E1
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 13:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=NFxfsp06lyRCY10yxDG+j91u6X2oQuXM0g9r3DGGHig=; b=E
 d7QzX0uKnB10S1oxHpa+QBT15dBgs5woaNO1VbnJ61uqPB7jUSCIz4VqZz3krhCj
 1ZVGH/tG1vPSfeFc2QsOrAMUqy1RMl8qR2JfIPejp/55EmXLz11z7QQ43yv04POi
 ZvV70Hxuq9scSNu8ko8TCB4vvTODShJKmns+xglOiQ=
Received: from w15303746062$163.com ( [113.200.174.80] ) by
 ajax-webmail-wmsvr-40-149 (Coremail) ; Thu, 28 May 2026 21:49:58 +0800
 (CST)
X-Originating-IP: [113.200.174.80]
Date: Thu, 28 May 2026 21:49:58 +0800 (CST)
From: w15303746062  <w15303746062@163.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 sumit.semwal@linaro.org, jeffy.chen@rock-chips.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 "Mingyu Wang" <25181214217@stu.xidian.edu.cn>
Subject: Re:Re: [PATCH v2] drm/prime: fix dangling dmabuf entries after
 handle release
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <62c256eb-1df4-4633-8040-222895b54f97@amd.com>
References: <0e12ce28-f5b7-4ffa-849c-df9ad1796e22@amd.com>
 <20260528132932.1078483-1-w15303746062@163.com>
 <62c256eb-1df4-4633-8040-222895b54f97@amd.com>
X-NTES-SC: AL_Qu2cC/WcuUki7iOdYekfmU0Qguw9Xcq5uPkj34FWN5t8jCLr2iAKW0JFIHb04eyMFRyerjiMcBZ1+ONjdJh8W6EFZutYLvilnzrxQVlQsWMr+w==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7bbb8946.9d19.19e6ed958df.Coremail.w15303746062@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: lSgvCgD3f6cGSBhqZ9GtAA--.11991W
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC4wazl2oYSAZ8OAAA35
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

SGkgQ2hyaXN0aWFuLAoKVGhhbmsgeW91IGZvciBpbnNpc3Rpbmcgb24gdGhpcy4gSSd2ZSBub3cg
Z29uZSB0aHJvdWdoIGFsbCBjYWxsZXJzCm9mIGRybV9wcmltZV9hZGRfYnVmX2hhbmRsZSgpIGlu
IGRybV9wcmltZS5jLgoKWW91IGFyZSBhYnNvbHV0ZWx5IHJpZ2h0OiBib3RoIGRybV9nZW1fcHJp
bWVfZmRfdG9faGFuZGxlKCkgYW5kCmRybV9nZW1fcHJpbWVfaGFuZGxlX3RvX2RtYWJ1ZigpIHBl
cmZvcm0gdGhlIGxvb2t1cCB1bmRlcgpwcmltZV9mcHJpdi0+bG9jayBiZWZvcmUgYWRkaW5nLCBz
byBhIGR1cGxpY2F0ZSBoYW5kbGUgc2hvdWxkIGluZGVlZApuZXZlciBiZSBpbnNlcnRlZCB0aHJv
dWdoIHRob3NlIHBhdGhzLgoKVGhhdCBzYWlkLCB0aGUgc3l6a2FsbGVyIHJlcG9ydCBjbGVhcmx5
IHNob3dzIHRoYXQgdGhlIGRtYWJ1ZnMgdHJlZQppcyBub3QgZW1wdHkgd2hlbiBkcm1fcHJpbWVf
ZGVzdHJveV9maWxlX3ByaXZhdGUoKSBydW5zLCB3aGljaCBtZWFucwpzb21lIGVudHJ5IHdhc24n
dCByZW1vdmVkLiBHaXZlbiB0aGF0IHRoZSBub3JtYWwgYWRkL3JlbW92ZSBwYXRocwphcHBlYXIg
Y29ycmVjdCwgdGhlIHRyaWdnZXIgbWlnaHQgYmUgc29tZXRoaW5nIG1vcmUgc3VidGxlIOKAlCBw
ZXJoYXBzCmEgZHJpdmVyLXNwZWNpZmljIGNhbGxiYWNrIHRoYXQgYnlwYXNzZXMgdGhlIGdlbmVy
aWMgaGVscGVycywgb3IgYW4KZXJyb3IgcGF0aCB0aGF0IGxlYXZlcyBhbiBvcnBoYW4gaW4gdGhl
IGRtYWJ1ZnMgdHJlZS4gSSBoYXZlbid0IGJlZW4KYWJsZSB0byBpZGVudGlmeSB0aGUgZXhhY3Qg
dHJpZ2dlciB5ZXQuCgpUaGUgcHJvcG9zZWQgY2hhbmdlIHRvIGRybV9wcmltZV9yZW1vdmVfYnVm
X2hhbmRsZSgpIChyZXN0YXJ0IHNlYXJjaAppbnN0ZWFkIG9mIGJyZWFrKSBpcyBpbnRlbmRlZCBh
cyBhIHNtYWxsIHJvYnVzdG5lc3MgaW1wcm92ZW1lbnQsIG5vdAphIGZpeCBmb3IgYSBjb25maXJt
ZWQgcmFjZS4gSW4gdGhlIG5vcm1hbCBjYXNlIGl0IHdpbGwgc3RpbGwgZXhlY3V0ZQpvbmx5IG9u
Y2UsIGJ1dCBpZiB0aGUgdHJlZXMgZXZlciBiZWNvbWUgaW5jb25zaXN0ZW50IGZvciBhbnkgcmVh
c29uLAppdCB3aWxsIGNsZWFuIHVwIGFsbCBlbnRyaWVzIGZvciB0aGUgZ2l2ZW4gaGFuZGxlIGFu
ZCBwcmV2ZW50IHRoZQpXQVJOSU5HLgoKV291bGQgeW91IGJlIG9rYXkgd2l0aCBzdWNoIGEgZGVm
ZW5zaXZlIGFwcHJvYWNoLCBvciB3b3VsZCB5b3UgcHJlZmVyCnRoYXQgd2UgZmlyc3QgdHJhY2sg
ZG93biB0aGUgcHJlY2lzZSB0cmlnZ2VyIChlLmcuIHdpdGggYWRkaXRpb25hbApXQVJOcyBvciB0
cmFjaW5nKT8KClRoYW5rcywKTWluZ3l1
