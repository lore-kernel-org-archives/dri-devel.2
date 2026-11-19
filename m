Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FC4606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=PRp+NI4e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C037710E880;
	Thu, 19 Nov 2026 12:51:22 +0000 (UTC)
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Thu, 19 Nov 2026 12:51:15 UTC
Received: from mail-m128245.netease.com (mail-m128245.netease.com
 [103.209.128.245])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCD5810E880
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 12:51:15 +0000 (UTC)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AB2AtQBLLG04vL*MjX4Nuap6.3.1795092368475.Hmail.202321181@mail.sdu.edu.cn>
To: Helge Deller <deller@gmx.de>
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gZmJkZXY6IHMzYy1mYjogRml4IHBvdGVudGlhbCByZWdpc3RyYXRpb24gY29ycnVwdGlvbiBvbiBwcm9iZSBmYWlsdXJl?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com web
In-Reply-To: <4fba8bdb-de77-4418-8ffc-7ad6982e8027@gmx.de>
References: <20261118-324f82bd41-fbdev-0@mail.sdu.edu.cn>
 <4fba8bdb-de77-4418-8ffc-7ad6982e8027@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received: from 202321181@mail.sdu.edu.cn( [101.76.249.61] ) by ajax-webmail (
 [127.0.0.1] ) ; Thu, 19 Nov 2026 20:46:08 +0800 (GMT+08:00)
From: =?UTF-8?B?5p2O5bm/56GV?= <liguangshuo@mail.sdu.edu.cn>
Date: Thu, 19 Nov 2026 20:46:08 +0800 (GMT+08:00)
X-HM-Tid: 0aa1f3d795c3d0cdkusy309171cb1601f
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMVHpP02bZAKsMEiErRSAekjx+ys+KNZNl0PLwl
 f2MeqR5lbiqKsoq8sm3hZVy9q3VVBNOjIUwfWq1GfV2NBR9WJV5pp9Gwt04oeFjraKOA9zEyL3vE
 n+LQX4zQhIbxZm+In4xyL2K8J8TailzhGVoxc=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGE9KVkweHUhCTB8eSEpDQlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVCQk
 lOS1VKS0tVSkJLQlkG
DKIM-Signature: a=rsa-sha256;
 b=PRp+NI4eALnkYh9Hsk8tyTPvzcrEnYqzDucBQ5CHP7qMfoD7ARx6CZcO+eV5Vv3hdiBql6H/dVgDo4HXkFkketkdYtHxVSQLgw+RV0FesUdUxsDzMLJQ0/KvK2ce3JiLP67zBET4JRrK8ANy4Ht1vPg/u8TTHHSPiWVBaILeSkg=;
 c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1; 
 bh=dBY8CS86QZYf1TpdBjExJrHDGi63C9W6Ery8DeqRoBQ=;
 h=date:mime-version:subject:message-id:from;
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

CgpIaSBIZWxnZSwKClRoYW5rcyBmb3IgdGhlIHJldmlldy4KCkZyb206IEhlbGdlIERlbGxlciA8
ZGVsbGVyQGdteC5kZT4KRGF0ZTogMjAyNi0xMS0xOSAwMjoxNzowOApUbzogIEd1YW5nc2h1byBM
aSA8bGlndWFuZ3NodW9AbWFpbC5zZHUuZWR1LmNuPixKaW5nb28gSGFuIDxqaW5nb29oYW4xQGdt
YWlsLmNvbT4KQ2M6ICBsaW51eC1mYmRldkB2Z2VyLmtlcm5lbC5vcmcsZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZyxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcKU3ViamVjdDogUmU6IFtQQVRDSF0gZmJkZXY6IHMzYy1mYjogRml4IHBvdGVu
dGlhbCByZWdpc3RyYXRpb24gY29ycnVwdGlvbiBvbiBwcm9iZSBmYWlsdXJlPk9uIDExLzE4LzI2
IDE1OjIyLCBHdWFuZ3NodW8gTGkgd3JvdGU6Cj4+IFByb2JlIGZhaWx1cmUgY2xlYW51cCBjYWxs
cyB1bnJlZ2lzdGVyX2ZyYW1lYnVmZmVyKCkgZXZlbiB3aGVuIHRoZQo+PiB3aW5kb3cgaGFzIG5v
dCBiZWVuIHJlZ2lzdGVyZWQuIEl0cyB6ZXJvLWluaXRpYWxpemVkIG5vZGUgY2FuIHRoZW4KPj4g
cmVtb3ZlIGFub3RoZXIgZnJhbWVidWZmZXIgZnJvbSByZWdpc3RlcmVkX2ZiWzBdLgo+PiAKPj4g
VHJhY2sgc3VjY2Vzc2Z1bCByZWdpc3RyYXRpb24gYW5kIG9ubHkgdW5yZWdpc3RlciB0aG9zZSBm
cmFtZWJ1ZmZlcnMuCj4+IEFsc28gc2tpcCBlbXB0eSB3aW5kb3cgc2xvdHMgd2hpbGUgdW53aW5k
aW5nIGEgZmFpbGVkIHByb2JlLgo+PiAKPj4gVGhpcyBpc3N1ZSB3YXMgZm91bmQgYnkgb3VyIHN0
YXRpYyBhbmFseXNpcyB0b29sIHVuZGVyIGRldmVsb3BtZW50Lgo+Cj5JIHRoaW5rIHMzY19mYl9w
cm9iZV93aW4oKSBuZWVkcyB0byBjbGVhbiB1cCB3aGVuIHNvbWUgdGhpbmdzCj5saWtlIGNtYXAg
ZmFpbCB0byBiZSBhbGxvY2F0ZWQuCj5Zb3VyIHBhdGNoIHNlZW1zIHRvIGp1c3Qgd29yayBhcm91
bmQgb25lIG9mIHRoZSBwb3NzaWJsZSBwaXRmYWxscy4KPgo+SGVsZ2UKPgoKczNjX2ZiX3Byb2Jl
X3dpbigpIHNldHMgKnJlcyBlYXJseSBhbmQgY2FycmllcyBvbiBpZiBmYl9hbGxvY19jbWFwKCkK
ZmFpbHMuIEkgdGhpbmsgaXQgc2hvdWxkIHVud2luZCB0aGUgY3VycmVudCB3aW5kb3cgb24gZmFp
bHVyZSBhbmQgc2V0CipyZXMgb25seSBhZnRlciByZWdpc3Rlcl9mcmFtZWJ1ZmZlcigpIHN1Y2Nl
ZWRzLiBUaGF0IHdvdWxkIGxlYXZlIHRoZQpjYWxsZXIgd2l0aCBqdXN0IHRoZSByZWdpc3RlcmVk
IHdpbmRvd3MgdG8gY2xlYW4gdXAuCgpJcyB0aGF0IHdoZXJlIHlvdSdkIHB1dCB0aGUgY2xlYW51
cD8gSWYgc28sIEknbGwgc2VuZCBhIHYyIHdpdGhvdXQKdGhlIGV4dHJhIHJlZ2lzdHJhdGlvbiBm
bGFnLgoKVGhhbmtzLApHdWFuZ3NodW8K
