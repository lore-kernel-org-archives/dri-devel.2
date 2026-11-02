Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F968606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 02:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ite.com.tw header.i=@ite.com.tw header.a=rsa-sha256 header.s=dkim header.b=kP+bNpri
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A0EF10E4BD;
	Mon,  2 Nov 2026 02:05:37 +0000 (UTC)
Received: from ironport.ite.com.tw (unknown [210.202.87.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DF2C10E4BD
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 02:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ite.com.tw; s=dkim;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=x+uuUAbF9qdDvNA9GjFaKotM8VJvuGY6kRfl7/BOzKY=;
 b=kP+bNprip+pknwKueroQ70hjaoIxtnz85nVypofuDpxFl4SfCIKbr3L2
 As3vVimGxg8vxaHCYbnHtT3coheU3FDzduHvJOAUzVl8LB3+lt77Q/m95
 G2VTg6pvIdNK8qWx/ozXb21Mw1CQ57q7OS+ECggY/OP4Hej9uzH+wchAq
 y39S/kwjtqqRAyvN2w2YEpLJbHGBQy+qq3YOcpeuICI3VMFWoUfBq8bLE
 hbNcJ5KkVC774cS+h/IajECWC/1a9XFY41HXlnkH69IVV2a4Km9nDihZ7
 Y8nh13eTzzsmqU93eUGK1HnfERLLHy0NgybkKW9Gj6hzl+qBcqXsOfFbp Q==;
X-CSE-ConnectionGUID: 1kbrKPe1TIGxBPtHTx2Guw==
X-CSE-MsgGUID: XOvGeJ4kQhyceyjz0y+bZA==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
 by ironport.ite.com.tw with ESMTP; 02 Nov 2026 10:04:24 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw
 [192.168.15.58]) by mse.ite.com.tw with ESMTP id 6A224M9J094652;
 Mon, 2 Nov 2026 10:04:22 +0800 (+08)
 (envelope-from Hermes.Wu@ite.com.tw)
Received: from TPEMAIL1.internal.ite.com.tw (192.168.15.58) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 2 Nov 2026 10:04:20 +0800
Received: from TPEMAIL1.internal.ite.com.tw ([fe80::63c1:9095:c5a6:3291]) by
 TPEMAIL1.internal.ite.com.tw ([fe80::63c1:9095:c5a6:3291%3]) with mapi id
 15.02.2562.046; Mon, 2 Nov 2026 10:04:20 +0800
From: <Hermes.Wu@ite.com.tw>
To: <krzk@kernel.org>
CC: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
 <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <luca.ceresoli@bootlin.com>,
 <Pet.Weng@ite.com.tw>, <Kenneth.Hung@ite.com.tw>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dmitry.baryshkov@oss.qualcomm.com>
Subject: RE: [PATCH v5 1/2] dt-bindings: display: bridge: Add ITE IT6162 MIPI
 DSI to HDMI bridge
Thread-Topic: [PATCH v5 1/2] dt-bindings: display: bridge: Add ITE IT6162 MIPI
 DSI to HDMI bridge
Thread-Index: AQHdaFTsxo4HRmH1TUmF9BCuflkFHbcV46rQ//9+WYCABKlI8A==
Date: Mon, 2 Nov 2026 02:04:20 +0000
Message-ID: <6af49c44a6bb477f8038266d3621bfab@ite.com.tw>
References: <20261029-upstream-6162-v5-0-8369f9e5afe6@ite.com.tw>
 <20261029-upstream-6162-v5-1-8369f9e5afe6@ite.com.tw>
 <20261030-jolly-mantis-from-betelgeuse-2f0db1@quoll>
 <436b4159ce1247c6ab3974f573ca6037@ite.com.tw>
 <182ebaf9-0e6c-413a-971a-396ee8cd6b5b@kernel.org>
In-Reply-To: <182ebaf9-0e6c-413a-971a-396ee8cd6b5b@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tm-snts-smtp: A427302722CA596491ABEBEA4F7B6B4BDBC9845A01224BF1445725501DBBB78A2002:8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MAIL: mse.ite.com.tw 6A224M9J094652
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgS3J6eXN6dG9mDQoNCk9uIDMwLzEwLzIwMjYgMTE6NDksIEtyenlzenRvZiBLb3psb3dza2kg
d3JvdGU6DQo+IE9uIDMwLzEwLzIwMjYgMTE6NDQsIEhlcm1lcy5XdUBpdGUuY29tLnR3IHdyb3Rl
Og0KPj4gSSByYW4gY2hlY2twYXRjaC5wbCwgd2l0aCBhbmQgd2l0aG91dCAtLXN0cmljdCwgb24g
Ym90aCBwYXRjaGVzLiBUaGUNCj4NCj4gSSBkb24ndCBiZWxpZXZlIGluIHN1Y2ggY2FzZSB0aGF0
IHlvdSBydW4gb24gYW55IHZhbGlkIGtlcm5lbCB0cmVlLg0KPg0KPiBQbGVhc2UgZml4IHlvdXIg
d29ya2Zsb3csIGJlY2F1c2UgaXQgc2VlbXMgeW91ICB3b3JrIG9uIHNvbWUgYW5jaWVudA0KPiB0
cmVlIChkb24ndCwgaW5zdGVhZCB1c2UgbWFpbmxpbmUpIG9yIHdvcmsgb24gZm9yayBvZiBrZXJu
ZWwgKGRvbid0LA0KPiBpbnN0ZWFkIHVzZSBtYWlubGluZSkuDQoNClNvcnJ5LCBteSBtaXN0YWtl
Lg0KSSByYW4gY2hlY2twYXRjaC5wbCBmcm9tIHRoZSBkcm0tbWlzYyB0cmVlJ3MgZHJtLW1pc2Mt
bmV4dCBicmFuY2gsIHdoaWNoIHRoZSBzZXJpZXMgaXMgYmFzZWQgb24uIA0KVGhhdCB0cmVlIGRv
ZXMgbm90IGhhdmUgY29tbWl0IDFlMDM1Mjk3ZmZkYSAoImRvY3M6IHJlbW92ZSBBc3Npc3RlZC1i
eSByZWZlcmVuY2VzIikgeWV0LCBzbyBpdHMgY2hlY2twYXRjaC5wbCBzdGlsbCBhY2NlcHRzIHRo
ZSBBc3Npc3RlZC1ieSB0YWcuDQpXaXRoIGNoZWNrcGF0Y2gucGwgZnJvbSBtYWlubGluZSBJIGNh
biBzZWUgdGhlIHdhcm5pbmdzIG5vdy4gSSB3aWxsIGRyb3AgdGhlIHRhZyBpbiB2NiBhbmQgY2hl
Y2sgdGhlIHBhdGNoZXMgd2l0aCBjaGVja3BhdGNoLnBsIGZyb20gbWFpbmxpbmUgYmVmb3JlIHNl
bmRpbmcuDQoNCk9uZSBxdWVzdGlvbiBzbyBJIGdldCB2NiByaWdodDogc2hvdWxkIEkga2VlcCBi
YXNpbmcgdGhlIHNlcmllcyBvbiBkcm0tbWlzYy1uZXh0LCBzaW5jZSB0aGUgYnJpZGdlIHBhdGNo
ZXMgZ28gdGhyb3VnaCBkcm0tbWlzYywgYW5kIG9ubHkNCnVzZSBtYWlubGluZSBmb3IgY2hlY2tw
YXRjaC5wbCBhbmQgdGhlIG90aGVyIHRvb2xzPyBPciB3b3VsZCB5b3UgcHJlZmVyIHRoZSBzZXJp
ZXMgdG8gYmUgYmFzZWQgb24gbWFpbmxpbmU/DQoNClRoYW5rcywNCkhlcm1lcw0K
