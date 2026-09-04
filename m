Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B79CC61DD6
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B45DD10E1AC;
	Fri,  4 Sep 2026 11:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="FnmN2lfn";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12E7210E1AC
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 11:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=X59egMSYDD+fE2fzFBggAtOS3MUTfnxcCwKe29Q8yD8=; b=F
 nmN2lfnW3b9tBbPbd/9jZ97NII9zPXTJftpLtim88qJA1A3Svuhzip3AJadw2v3G
 STJF196aHB3EL21x5KWIFwAqhZmIRd9Vc8jEYTmxE8WlnDUwxmbdBD0gcfhI5ayS
 6jo9KfZS79BAi+p8CX8KHSJxHScHunmn+2rgi0CYgc=
Date: Fri, 4 Sep 2026 19:13:03 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Johan Jonker" <jbx6244@gmail.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 andy.yan@rock-chips.com, hjc@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [RFC PATCH v1] drm: rockchip: add
 drm_plane_create_blend_mode_property
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <a239b296-ba90-45d1-b8b8-713ab29fda5c@gmail.com>
References: <1ab6fb88-3b84-49b5-aa05-202a84edbd3d@gmail.com>
 <25031028.6Emhk5qWAg@diego>
 <a239b296-ba90-45d1-b8b8-713ab29fda5c@gmail.com>
X-NTES-SC: AL_Qu2TCvmZv0sj5SSfZekfmUgWjuw/WsG1v/Ul1YBSP556jCHrxzoRdHxjAkDS7+6eBDGRrDGqWTZt7uBVZIN9ZLsi34t6cze7ZrnBPpeLFqZdGQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3ff2201c.8fbe.1a06c1f43f5.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: lCgvCgD3X9y_p5pqQtI_AA--.6224W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbC7h9auGqap7-zwAAA3I
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

CgpIZWxsbG/vvIwKCkF0IDIwMjYtMDgtMjQgMDU6MDY6NDUsICJKb2hhbiBKb25rZXIiIDxqYng2
MjQ0QGdtYWlsLmNvbT4gd3JvdGU6Cj4KPgo+T24gOC8yMy8yNiAyMToxOSwgSGVpa28gU3TDvGJu
ZXIgd3JvdGU6Cj4+IEhpIEpvaGFuLAo+PiAKPj4gQW0gU29ubnRhZywgMjMuIEF1Z3VzdCAyMDI2
LCAxNDoyOTowOSBNaXR0ZWxldXJvcMOkaXNjaGUgU29tbWVyemVpdCBzY2hyaWViIEpvaGFuIEpv
bmtlcjoKPj4+IEEgdmFsaWRhdGVfYmxlbmRfbW9kZV9mb3JfYWxwaGFfZm9ybWF0cygpIGZ1bmN0
aW9uIHdhcyBhZGRlZCB0aGF0Cj4+PiBmaWxscyB0aGUga2VybmVsIGxvZyB3aXRoIHdhcm5pbmdz
IGZvciBSb2NrY2hpcCBWT1AgdmVyc2lvbiAxIFNvQ3MuCj4+PiBBZGQgYSBkcm1fcGxhbmVfY3Jl
YXRlX2JsZW5kX21vZGVfcHJvcGVydHkoKSBmdW5jdGlvbiBhcyBmaXguCj4+IAo+Cj4+IFRoaXMg
aXMgbWlzc2luZyBleHBsYW5hdGlvbiBvbiB3aHkgUElYRUxfTk9ORSBpcyB0aGUgY29ycmVjdCB2
YWx1ZS4KPj4gCj4+IFZPUDIgc2VlbXMgdG8gc3VwcG9ydCBhbGwgMyBibGVuZCBtb2Rlcz8gU28g
YSBzZW50ZWNlIGV4cGxhaW5pbmcKPj4gdGhlIHBpeGVsX25vbmUgdmFsdWUgd291bGQgYmUgaGVs
cGZ1bC4KPj4gCj4+IAo+Cj5IaSwKPgo+SW4gdGhlIHZvcF9wbGFuZV9hdG9taWNfdXBkYXRlKCkg
ZnVuY3Rpb24gdGhlcmUncyBhIGNvbW1lbnQgd2l0aCB3aW4wIGJsZW5kIGJyb2tlbjoKPgo+CS8q
Cj4JICogQmxlbmRpbmcgd2luMCB3aXRoIHRoZSBiYWNrZ3JvdW5kIGNvbG9yIGRvZXNuJ3Qgc2Vl
bSB0byB3b3JrCj4JICogY29ycmVjdGx5LiBXZSBvbmx5IGdldCB0aGUgYmFja2dyb3VuZCBjb2xv
ciwgbm8gbWF0dGVyIHRoZSBjb250ZW50cwo+CSAqIG9mIHRoZSB3aW4wIGZyYW1lYnVmZmVyLiAg
SG93ZXZlciwgYmxlbmRpbmcgcHJlLW11bHRpcGxpZWQgY29sb3IKPgkgKiB3aXRoIHRoZSBkZWZh
dWx0IG9wYXF1ZSBibGFjayBkZWZhdWx0IGJhY2tncm91bmQgY29sb3IgaXMgYSBuby1vcCwKPgkg
KiBzbyB3ZSBjYW4ganVzdCBkaXNhYmxlIGJsZW5kaW5nIHRvIGdldCB0aGUgY29ycmVjdCByZXN1
bHQuCj4JICovCj4KCiAgICAgQWxsIFZPUCAxIGRvIG5vdCBzdXBwb3J0IGFscGhhIGJsZW5kaW5n
IHdpdGggYmFja2dyb3VuZC4KICAgIEFsc28sIHNvbWUgVk9QcyBkbyBub3Qgc3VwcG9ydCBhbHBo
YSB3aGVuIHNjYWxpbmcgaXMgZW5hYmxlZCwgZXhjZXB0IHRob3NlIG1hcmtlZCB3aXRoIFZPUF9G
RUFUVVJFX0FMUEhBX1NDQUxF77yMIHNlZVswXQoKWzBdaHR0cHM6Ly9naXRodWIuY29tL3JvY2tj
aGlwLWxpbnV4L2tlcm5lbC9ibG9iL2RldmVsb3AtNi4xMi9kcml2ZXJzL2dwdS9kcm0vcm9ja2No
aXAvcm9ja2NoaXBfdm9wX3JlZy5jCgo+SW4gdGhlIGZ1bmN0aW9uIHZvcDJfcGxhbmVfaW5pdCgp
IHRoZXJlIGFyZSB0aGVzZSBibGVuZHM6IAo+Cj4JdW5zaWduZWQgaW50IGJsZW5kX2NhcHMgPSBC
SVQoRFJNX01PREVfQkxFTkRfUElYRUxfTk9ORSkgfAo+CQkJCSAgQklUKERSTV9NT0RFX0JMRU5E
X1BSRU1VTFRJKSB8Cj4JCQkJICBCSVQoRFJNX01PREVfQkxFTkRfQ09WRVJBR0UpOwo+Cj5NeSBx
dWVzdGlvbjoKPkNvdWxkIHNvbWVvbmUgd2l0aCBtb3JlIGtub3ctaG93IHRlbGwgdXMgd2hhdCBW
T1AgdmVyc2lvbiAxIGlzIGNhcGFibGUgb2Y/Cj5JcyB0aGVyZSBhbnl0aGluZyB0aGF0IG5lZWRz
IHRvIGJlIHNldCBsaWtlIGluIG90aGVyIGRyaXZlcnM/Cj4KPkZvciBleGFtcGxlOgo+CQlzd2l0
Y2ggKHBpeGVsX2JsZW5kX21vZGUpIHsKPgkJY2FzZSBEUk1fTU9ERV9CTEVORF9QUkVNVUxUSToK
PgkJCWJyZWFrOwo+CQljYXNlIERSTV9NT0RFX0JMRU5EX0NPVkVSQUdFOgo+CQkJYnJlYWs7Cj4J
CWNhc2UgRFJNX01PREVfQkxFTkRfUElYRUxfTk9ORToKPgkJZGVmYXVsdDoKPgkJCWJyZWFrOwo+
CQl9Cj4KPklmIHNvbWVvbmUgY29tZXMgdXAgd2l0aCBhbm90aGVyIHNvbHV0aW9uL3BhdGNoIHRo
YXQncyBhbHNvIGZpbmUsIGFzIGxvbmcgdGhlIGtlcm5lbCB3YXJuaW5ncyBhcmUgZ29uZS4KPgo+
VGhhbmtzIQo+Cj5Kb2hhbgo+Cj4KPgo+PiBIZWlrbwo+PiAKPj4+IFNpZ25lZC1vZmYtYnk6IEpv
aGFuIEpvbmtlciA8amJ4NjI0NEBnbWFpbC5jb20+Cj4+PiAtLS0KPj4+Cj4+PiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvMjAyNjA1MjYxODE3MDAuMjUzMTAtMy1sZWFuZHJvLnJpYmVpcm9A
Y29sbGFib3JhLmNvbS8KPj4+IC0tLQo+Pj4gIGRyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9yb2Nr
Y2hpcF9kcm1fdm9wLmMgfCAyICsrCj4+PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBf
ZHJtX3ZvcC5jIGIvZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlwL3JvY2tjaGlwX2RybV92b3AuYwo+
Pj4gaW5kZXggMDA5MGQ4ZmYwYzc5Li4wYmM1YjYwNmYwMjEgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBfZHJtX3ZvcC5jCj4+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBfZHJtX3ZvcC5jCj4+PiBAQCAtMTg1MCw2ICsxODUw
LDggQEAgc3RhdGljIHZvaWQgdm9wX3BsYW5lX2FkZF9wcm9wZXJ0aWVzKHN0cnVjdCBkcm1fcGxh
bmUgKnBsYW5lLAo+Pj4gIAlpZiAoZmxhZ3MpCj4+PiAgCQlkcm1fcGxhbmVfY3JlYXRlX3JvdGF0
aW9uX3Byb3BlcnR5KHBsYW5lLCBEUk1fTU9ERV9ST1RBVEVfMCwKPj4+ICAJCQkJCQkgICBEUk1f
TU9ERV9ST1RBVEVfMCB8IGZsYWdzKTsKPj4+ICsJZHJtX3BsYW5lX2NyZWF0ZV9ibGVuZF9tb2Rl
X3Byb3BlcnR5KHBsYW5lLAo+Pj4gKwkJCQkJICAgICBCSVQoRFJNX01PREVfQkxFTkRfUElYRUxf
Tk9ORSkpOwo+Pj4gIH0KPj4+ICAKPj4+ICBzdGF0aWMgaW50IHZvcF9jcmVhdGVfY3J0YyhzdHJ1
Y3Qgdm9wICp2b3ApCj4+Pgo+PiAKPj4gCj4+IAo+PiAKPgo=
