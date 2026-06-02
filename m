Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C9ACD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 13:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47402113A11;
	Tue,  2 Jun 2026 13:27:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="eHAZ+Hwb";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77F50113A11
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 13:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=UEGrnMJfjuJTN/ukZi5Az/WjTew/M9r24Ec276ZDEkA=; b=e
 HAZ+HwbIWaFhOxm1IP1VjtUnKgBPsNrnnnITTca4q2V4JVJ8Ysxz5UFgMxoTBBEx
 2QL5247COpz1dcoot+flXT7XGH8Vqq2/sd6eq7T3xSZGuhmkZkLfxH6pzqx7obQj
 y8SqhTTSMkk9Rq0iZC/OQkHDDkRpZcINXqXX0Hrnkk=
Received: from andyshrk$163.com ( [61.154.14.86] ) by
 ajax-webmail-wmsvr-40-120 (Coremail) ; Tue, 2 Jun 2026 21:25:03 +0800 (CST)
X-Originating-IP: [61.154.14.86]
Date: Tue, 2 Jun 2026 21:25:03 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: "Sandy Huang" <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 "Andy Yan" <andy.yan@rock-chips.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re:[PATCH v2 1/2] drm/rockchip: vop2: Rename CSC_BT2020 to CSC_BT2020L
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260601-vop2-bg-yuv-v2-1-e5aef1d16fec@collabora.com>
References: <20260601-vop2-bg-yuv-v2-0-e5aef1d16fec@collabora.com>
 <20260601-vop2-bg-yuv-v2-1-e5aef1d16fec@collabora.com>
X-CM-CTRLMSGS: orIOyHBsdXM9MTc4MDQwNjcwMjQ1N19lZTQ5OTRjYWQxNTQ3Yjk3MjcyNTg1M
 GQ4NWFkMjdiMA==
X-NTES-SC: AL_Qu2TAvibuU8r5SabZ+kfmUgWjuw/WsG1v/Ul1YBSP556jDLp4yQsdlhFB13k6v+RMTGlqAieVTxg0OFXWa1WfaYt9nJWp8HBWVM13wAjL2z6rw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7bca6efb.a37a.19e88825619.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: eCgvCgDHT+ew2R5qI9cAAA--.8190W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbC7g-DImoe2a-5LgAA3V
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

CkhlbGxvIENyaXN0aWFu77yMCgpBdCAyMDI2LTA2LTAyIDAyOjAwOjAzLCAiQ3Jpc3RpYW4gQ2lv
Y2FsdGVhIiA8Y3Jpc3RpYW4uY2lvY2FsdGVhQGNvbGxhYm9yYS5jb20+IHdyb3RlOgo+UmVuYW1l
IENTQ19CVDIwMjAgdG8gQ1NDX0JUMjAyMEwgZm9yIGNvbnNpc3RlbmN5IHdpdGggdGhlIG90aGVy
Cj5saW1pdGVkLXJhbmdlIGVudW0gbWVtYmVycyAoQ1NDX0JUNjAxTCwgQ1NDX0JUNzA5TCkgYW5k
IHRvIGRpc3Rpbmd1aXNoCj5pdCBmcm9tIGEgcG90ZW50aWFsIGZ1dHVyZSBmdWxsLXJhbmdlIEJU
LjIwMjAgdmFyaWFudC4KPgo+U2lnbmVkLW9mZi1ieTogQ3Jpc3RpYW4gQ2lvY2FsdGVhIDxjcmlz
dGlhbi5jaW9jYWx0ZWFAY29sbGFib3JhLmNvbT4KPi0tLQo+IGRyaXZlcnMvZ3B1L2RybS9yb2Nr
Y2hpcC9yb2NrY2hpcF9kcm1fdm9wMi5jIHwgMiArLQo+IGRyaXZlcnMvZ3B1L2RybS9yb2NrY2hp
cC9yb2NrY2hpcF9kcm1fdm9wMi5oIHwgMiArLQo+IDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3Jv
Y2tjaGlwL3JvY2tjaGlwX2RybV92b3AyLmMgYi9kcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9j
a2NoaXBfZHJtX3ZvcDIuYwo+aW5kZXggYTE2MDA3N2E1MDdmLi42NGFjMDdjYjFiMGQgMTAwNjQ0
Cj4tLS0gYS9kcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBfZHJtX3ZvcDIuYwo+Kysr
IGIvZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlwL3JvY2tjaGlwX2RybV92b3AyLmMKPkBAIC02NTgs
NyArNjU4LDcgQEAgc3RhdGljIGludCB2b3AyX2NvbnZlcnRfY3NjX21vZGUoaW50IGNzY19tb2Rl
KQo+IAljYXNlIFY0TDJfQ09MT1JTUEFDRV9KUEVHOgo+IAkJcmV0dXJuIENTQ19CVDYwMUY7Cj4g
CWNhc2UgVjRMMl9DT0xPUlNQQUNFX0JUMjAyMDoKPi0JCXJldHVybiBDU0NfQlQyMDIwOwo+KwkJ
cmV0dXJuIENTQ19CVDIwMjBMOwo+IAlkZWZhdWx0Ogo+IAkJcmV0dXJuIENTQ19CVDcwOUw7Cj4g
CX0KPmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBfZHJtX3Zv
cDIuaCBiL2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9yb2NrY2hpcF9kcm1fdm9wMi5oCj5pbmRl
eCAzNzcyMjY1Mjg0NGEuLmZmY2IzOWMxMzBhYSAxMDA2NDQKPi0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9yb2NrY2hpcC9yb2NrY2hpcF9kcm1fdm9wMi5oCj4rKysgYi9kcml2ZXJzL2dwdS9kcm0vcm9j
a2NoaXAvcm9ja2NoaXBfZHJtX3ZvcDIuaAo+QEAgLTM3Myw3ICszNzMsNyBAQCBlbnVtIHZvcF9j
c2NfZm9ybWF0IHsKPiAJQ1NDX0JUNjAxTCwKPiAJQ1NDX0JUNzA5TCwKPiAJQ1NDX0JUNjAxRiwK
Pi0JQ1NDX0JUMjAyMCwKPisJQ1NDX0JUMjAyMEwsCj4gfTsKCgoKICBBY2tlZC1ieTogQW5keSBZ
YW4gPGFuZHlzaHJrQDE2My5jb20+CgoKPiAKPiBlbnVtIHNyY19mYWN0b3JfbW9kZSB7Cj4KPi0t
IAo+Mi41NC4wCg==
