Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0ACC88E70
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C59810EE3E;
	Mon, 14 Sep 2026 13:11:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="V7840osk";
	dkim-atps=neutral
X-Greylist: delayed 751 seconds by postgrey-1.36 at gabe;
 Mon, 14 Sep 2026 08:41:48 UTC
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B40E410E12E;
 Mon, 14 Sep 2026 08:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=05YNK+h/bbK08U3PySMOR0D54dDL/PFne0Hz4drePO0=; b=V
 7840oskOrXrSd13OT4o2/5csns4ndidjLHaNljsbZ5SNaUG64DIbCd4cacW3gFVm
 tZRertox7LwM8pqDRsBlKYtQW9FqsLRvuCvr6uaGOAqymI6tvl78XXBAS1h1uUJ6
 eO00eoOYr0ryBvB3zk5+JRqJE4kNn397+UxQYOooQA=
Date: Mon, 14 Sep 2026 16:28:46 +0800 (CST)
From: CJ <firefly0158@163.com>
To: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [BUG] drm/i915: general protection fault in i915_pci_probe on
 forced bind
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2TC/+cu00p4CaaYOkdmEsTju82UcS4ufQl245Xc98Figbk+QAgeFpPNFDG1NiRKyuJkh+TdQFs6cJxc45/KeXO6RNzPecFeNSHcVS0TA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3c467f81.7d23.1a09f0874aa.Coremail.firefly0158@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: hygvCgD3P7Y_sKdq_jAPAA--.18779W
X-CM-SenderInfo: piluvw1o1qikqy6rljoofrz/xtbC3h+-cWqnsD+7swAA3F
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Mailman-Approved-At: Mon, 14 Sep 2026 13:10:56 +0000
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

SGksCgoKSSBhbSByZXBvcnRpbmcgYSBnZW5lcmFsIHByb3RlY3Rpb24gZmF1bHQgaW4gdGhlIGk5
MTUgUENJIHByb2JlIHBhdGgsIHRyaWdnZXJlZApieSBhIHN5emthbGxlciByZXByb2R1Y2VyLiAg
VGhlIGlzc3VlIGlzIHJlcHJvZHVjaWJsZSB3aXRoIEhFQUQgY29tbWl0CmNlZTkzOTVhY2Q4MDQz
YmUwNjQ0YjI1YzM0YmZhODY2MjNmMmI5MzUgKHY3LjMtcmMxLCBMaW51eCA3LjMuMC1yYzEpLgoK
ClRoZSByZXByb2R1Y2VyIG1vdW50cyBzeXNmcywgd3JpdGVzICJpOTE1IiB0byB0aGUgZHJpdmVy
X292ZXJyaWRlIGF0dHJpYnV0ZSBvZgpQQ0kgZGV2aWNlIDAwMDA6MDA6MDEuMCwgYW5kIHRoZW4g
d3JpdGVzIHRoZSBkZXZpY2UgbmFtZSB0byB0aGUgaTkxNSBkcml2ZXIncwpiaW5kIGF0dHJpYnV0
ZS4gIFRoaXMgYmluZHMgdGhlIGk5MTUgZHJpdmVyIHRvIGEgUENJIGRldmljZSBpdCB3YXMgbmV2
ZXIgbWVhbnQKdG8gZHJpdmUuCgoKVGhlIHByb2JlIHJ1bnMgaW4gdGhlIHdvcmtxdWV1ZSB3b3Jr
ZXIga3dvcmtlci8wOjEgaW4gdGhlIHdvcmtfZm9yX2NwdV9mbgpjb250ZXh0LiAgS0FTQU4gcmVw
b3J0cyBhIG51bGwtcHRyLWRlcmVmIGluIHRoZSByYW5nZSBbMHgxOC0weDFmXSBhbmQgdGhlCmNv
bnNvbGUgc2hvd3MgYSBnZW5lcmFsIHByb3RlY3Rpb24gZmF1bHQgZm9yIHRoZSBub24tY2Fub25p
Y2FsIGFkZHJlc3MKMHhkZmZmZmMwMDAwMDAwMDAzLCB3aXRoIFJJUCBpbiBpOTE1X3BjaV9wcm9i
ZS4gIFRoZSBwYXRoIHJlYWNoZXMgdGhlIGRyaXZlcgp0aHJvdWdoIGxvY2FsX3BjaV9wcm9iZSBh
bmQgcGNpX2NhbGxfcHJvYmUgZnJvbSB0aGUgc3lzZnMgYmluZCBzdG9yZS4KCgpPbmUgcG9zc2li
bGUgY2F1c2UgaXMgdGhhdCBpOTE1X3BjaV9wcm9iZSB0YWtlcyBwZXItZGV2aWNlIGluZm9ybWF0
aW9uIHRoYXQgaXMKb25seSBwb3B1bGF0ZWQgZm9yIGRldmljZXMgdGhlIGRyaXZlciBpcyBzdXBw
b3NlZCB0byBtYXRjaCwgYW5kIGRlcmVmZXJlbmNlcyBpdAp3aXRob3V0IGEgdmFsaWRpdHkgY2hl
Y2ssIHNvIGEgZm9yY2VkIGJpbmQgb24gYW4gdW5yZWxhdGVkIFBDSSBkZXZpY2UgbGVhZHMgdG8g
YQpOVUxMIGRlcmVmZXJlbmNlLiAgVGhpcyBsb29rcyBsaWtlIGEgbWlzc2luZyBndWFyZCBhZ2Fp
bnN0IGEgZHJpdmVyL2RldmljZQptaXNtYXRjaCBvbiB0aGUgcHJvYmUgcGF0aC4gIEkgYW0gcmVw
b3J0aW5nIHRoZSBmYXVsdCBhbmQgdGhlIHBhdGggYXMgb2JzZXJ2ZWQuCgoKVGhpcyBhcHBlYXJz
IHRvIGJlIGEgcmVjdXJyZW5jZSBvZiB0aGUgc3l6Ym90IGlzc3VlIHdob3NlIGV4dGVybmFsIGlk
IGlzCjY3NTViMWI0YmM4ZWU3NWZjYmE0LiAgSXQgcmVtYWlucyByZXByb2R1Y2libGUgb24gdjcu
My1yYzEuCgoKUmVwcm9kdWNlcjoKCgpzeXogcmVwcm9kdWNlcjoKbWtkaXJhdCgweGZmZmZmZmZm
ZmZmZmZmOWMsICYoMHg3ZjAwMDAwMDAxMDApPScuL3N5c1x4MDAnLCAweDFmZikKbW91bnQoMHgw
LCAmKDB4N2YwMDAwMDAwMTAwKT0nLi9zeXNceDAwJywgJigweDdmMDAwMDAwMDIwMCk9J3N5c2Zz
XHgwMCcsIDB4MCwgMHgwKQpyMCA9IG9wZW5hdCgweGZmZmZmZmZmZmZmZmZmOWMsICYoMHg3ZjAw
MDAwMDAzMDApPScuL3N5cy9idXMvcGNpL2RldmljZXMvMDAwMDowMDowMS4wL2RyaXZlcl9vdmVy
cmlkZVx4MDAnLCAweDEsIDB4MCkKd3JpdGUocjAsICYoMHg3ZjAwMDAwMDA0MDApPSdpOTE1XHgw
MCcsIDB4NSkKcjEgPSBvcGVuYXQoMHhmZmZmZmZmZmZmZmZmZjljLCAmKDB4N2YwMDAwMDAwNTAw
KT0nLi9zeXMvYnVzL3BjaS9kcml2ZXJzL2k5MTUvYmluZFx4MDAnLCAweDEsIDB4MCkKd3JpdGUo
cjEsICYoMHg3ZjAwMDAwMDA2MDApPScwMDAwOjAwOjAxLjBceDAwJywgMHhkKQoKCmNvbnNvbGUg
b3V0cHV0OsKgaHR0cHM6Ly9wYXN0ZWJpbi5jb20vcmF3L0hrWXJBeTFQCmtlcm5lbCBjb25maWc6
IGh0dHBzOi8vcGFzdGViaW4uY29tL3Jhdy8yR0xibVdIRgoKCktlcm5lbDoKCgpIRUFEIGNvbW1p
dDogY2VlOTM5NWFjZDgwNDNiZTA2NDRiMjVjMzRiZmE4NjYyM2YyYjkzNQpnaXQgdHJlZTogdXBz
dHJlYW0gKGxpbnV4LmdpdCksIHRlc3RlZCB0aHJvdWdoIHRoZSB2Ny4zLXJjMSBhbm5vdGF0ZWQg
dGFnIG9iamVjdArCoCDCoCDCoCDCoCDCoCDCoGU1ZTA0NzI2Y2RkMDQzZTMwOTY3NzA3MWFiMWI2
NWE0YjE4ZjQyMmIKa2VybmVsIHZlcnNpb246IDcuMy4wLXJjMSAjMSBQUkVFTVBUKGZ1bGwpCnRl
c3RlZCB0YWc6IHY3LjMtcmMxIChMaW51eCA3LjMtcmMxLCAyMDI2LTA4LTMwKQoKCkxldCBtZSBr
bm93IGlmIHlvdSBuZWVkIG1vcmUgZGV0YWlscyBvciB0ZXN0aW5nLgoKCkJlc3QgcmVnYXJkcywK
Q2hhbmdqaWFuCgoKCg==
