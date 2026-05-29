Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635D1CD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 11:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD70310FD6A;
	Fri, 29 May 2026 11:47:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="cRgk3b1h";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24D2810FD6A
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 11:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=94GyrtKUPcw6dUudljrdpDPI38g/F1ms8pwc++tMTSI=; b=c
 Rgk3b1hQkT6UQA8SK784y7gFHKJ5xWSNVvi3iaxZq7e78qRe5p/D1EdYCJVFzXCg
 tizlsk8uODVdo2OD1HS6AxAV1EqfJW2BFHba5PnZC8oCoep1XK8gVSZRL79/YFHf
 2o0nRT8OMu/dR2uIP0zoQ2oYqnKvD9CRlNJq9kxBVo=
Received: from w15303746062$163.com ( [113.200.174.80] ) by
 ajax-webmail-wmsvr-40-124 (Coremail) ; Fri, 29 May 2026 19:45:42 +0800
 (CST)
X-Originating-IP: [113.200.174.80]
Date: Fri, 29 May 2026 19:45:42 +0800 (CST)
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
In-Reply-To: <bb4d3330-822e-45ae-94f4-65ba0e351f57@amd.com>
References: <0e12ce28-f5b7-4ffa-849c-df9ad1796e22@amd.com>
 <20260528132932.1078483-1-w15303746062@163.com>
 <62c256eb-1df4-4633-8040-222895b54f97@amd.com>
 <7bbb8946.9d19.19e6ed958df.Coremail.w15303746062@163.com>
 <bb4d3330-822e-45ae-94f4-65ba0e351f57@amd.com>
X-NTES-SC: AL_Qu2TAvyeukkv5CiRYOkfmU0Qguw9Xcq5uPkj34FWN5t8jAvp6BgifHBkMWLY9tKqBSCQtgC+cAJg08FoUqNhfqckIc+3Gw44gLYit/sDw/2vEA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5ffc2647.95cf.19e738df1f7.Coremail.w15303746062@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: fCgvCgDXPyxnfBlqz22qAA--.908W
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC4wcZ-GoZfGfigQAA3K
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

SGkgQ2hyaXN0aWFuLAoKVGhhbmsgeW91IGZvciB5b3VyIGd1aWRhbmNlIGFuZCBwYXRpZW5jZSB0
aHJvdWdob3V0IHRoaXMgZGlzY3Vzc2lvbi4KCkFmdGVyIGZ1cnRoZXIgaW52ZXN0aWdhdGlvbiwg
SSByZWFsaXplIHRoYXQgaWRlbnRpZnlpbmcgdGhlIHByZWNpc2UKcm9vdCBjYXVzZSByZXF1aXJl
cyBhIGRlZXBlciB1bmRlcnN0YW5kaW5nIG9mIHRoZSBEUk0gc3Vic3lzdGVtIGFuZAphY2Nlc3Mg
dG8gdGhlIHNwZWNpZmljIHN5emthbGxlciByZXByb2R1Y2VyLCB3aGljaCBJIGN1cnJlbnRseSBs
YWNrLgoKVG8gYXZvaWQgd2FzdGluZyB5b3VyIHRpbWUgd2l0aCBpbmNvbXBsZXRlIHBhdGNoZXMs
IEknbGwgc3RlcCBiYWNrCmZyb20gdGhpcyBpc3N1ZSBmb3Igbm93IGFuZCBjb250aW51ZSBsZWFy
bmluZyB0aGUgY29kZWJhc2UuIElmIEkKbWFuYWdlIHRvIHJlcHJvZHVjZSB0aGUgcHJvYmxlbSBs
b2NhbGx5IG9yIGZpbmQgbW9yZSBjb25jcmV0ZQpldmlkZW5jZSwgSSdsbCBmb2xsb3cgdXAgd2l0
aCBhIHByb3BlciBhbmFseXNpcy4KClRoYW5rIHlvdSBhZ2FpbiBmb3IgdGhlIHJldmlldyBhbmQg
dGhlIHZhbHVhYmxlIGxlc3NvbnMuCgpSZWdhcmRzLApNaW5neXU=
