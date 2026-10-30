Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4EF606A330
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ite.com.tw header.i=@ite.com.tw header.a=rsa-sha256 header.s=dkim header.b=GDJEY1hS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7140E10E042;
	Fri, 30 Oct 2026 10:52:19 +0000 (UTC)
X-Greylist: delayed 367 seconds by postgrey-1.36 at gabe;
 Fri, 30 Oct 2026 10:52:12 UTC
Received: from ironport.ite.com.tw (unknown [210.202.87.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C77FD10E042
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ite.com.tw; s=dkim;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=daErkqpEX2p+EHTwW1aJ5d2AIBfSMk8MVtEa4tl2eZo=;
 b=GDJEY1hSLQhdkEcazYTp4lB+N9qq5W5tjrHuuORHCKXMnbFT2TD7ux3a
 2ryy3k+Qd5nw2X7NefRkRHDr+KGutJGC1Zw5EYO2Q6g2EuRSHA3ba6FNl
 HyYu/knsUHrflOCYHd82NC6isH3O1S7xONr84DBDURZcR8YHcyOALvO5F
 PmmtPkJRxGyiofRioZfJbzlGHUaFcnz28KSqXc2ue02oJLzFq9RcLTd92
 WKT/7h4BBupEf3se8BGGGz3y5ZK+qD1G7VO+Dx6HbbNFWPqJIMcV3nH0/
 XICMO44QuSJKaUUeCdZn4CI0LuVJJqIo6KVZHHlKwZFSAEGVXCXQ09GFd w==;
X-CSE-ConnectionGUID: epbCxJEMQKWlJNew/+d0Qg==
X-CSE-MsgGUID: 0o7rfbV0RXSS4wmGldWTbg==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
 by ironport.ite.com.tw with ESMTP; 30 Oct 2026 18:44:59 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw
 [192.168.15.58]) by mse.ite.com.tw with ESMTP id 69UAivJC090845;
 Fri, 30 Oct 2026 18:44:57 +0800 (+08)
 (envelope-from Hermes.Wu@ite.com.tw)
Received: from TPEMAIL1.internal.ite.com.tw (192.168.15.58) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 30 Oct 2026 18:44:56 +0800
Received: from TPEMAIL1.internal.ite.com.tw ([fe80::63c1:9095:c5a6:3291]) by
 TPEMAIL1.internal.ite.com.tw ([fe80::63c1:9095:c5a6:3291%3]) with mapi id
 15.02.2562.046; Fri, 30 Oct 2026 18:44:56 +0800
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
Thread-Index: AQHdaFTsxo4HRmH1TUmF9BCuflkFHbcV46rQ
Date: Fri, 30 Oct 2026 10:44:56 +0000
Message-ID: <436b4159ce1247c6ab3974f573ca6037@ite.com.tw>
References: <20261029-upstream-6162-v5-0-8369f9e5afe6@ite.com.tw>
 <20261029-upstream-6162-v5-1-8369f9e5afe6@ite.com.tw>
 <20261030-jolly-mantis-from-betelgeuse-2f0db1@quoll>
In-Reply-To: <20261030-jolly-mantis-from-betelgeuse-2f0db1@quoll>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tm-snts-smtp: 1E8508BF7AEC2E79E2DEE24730B3D461F8F4DCD4F42440042CB5FAD9DAFFB7272002:8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MAIL: mse.ite.com.tw 69UAivJC090845
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgS3J6eXN6dG9mDQo+DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBLcnp5
c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+IA0KPlNlbnQ6IEZyaWRheSwgT2N0b2Jl
ciAzMCwgMjAyNiA1OjU2IFBNDQo+VG86IEhlcm1lcyBXdSAo5ZCz5L2z5a6PKSA8SGVybWVzLld1
QGl0ZS5jb20udHc+DQo+Q2M6IEFuZHJ6ZWogSGFqZGEgPGFuZHJ6ZWouaGFqZGFAaW50ZWwuY29t
PjsgTmVpbCBBcm1zdHJvbmcgPG5laWwuYXJtc3Ryb25nQGxpbmFyby5vcmc+OyBSb2JlcnQgRm9z
cyA8cmZvc3NAa2VybmVsLm9yZz47IExhdXJlbnQgUGluY2hhcnQgPExhdXJlbnQucGluY2hhcnRA
aWRlYXNvbmJvYXJkLmNvbT47IEpvbmFzIEthcmxtYW4gPGpvbmFzQGt3aWJvby5zZT47IEplcm5l
aiBTa3JhYmVjIDxqZXJuZWouc2tyYWJlY0BnbWFpbC5jb20+OyBEYXZpZCBBaXJsaWUgPGFpcmxp
ZWRAZ21haWwuY29tPjsgU2ltb25hIFZldHRlciA8c2ltb25hQGZmd2xsLmNoPjsgTWFhcnRlbiBM
YW5raG9yc3QgPG1hYXJ0ZW4ubGFua2hvcnN0QGxpbnV4LmludGVsLmNvbT47IE1heGltZSBSaXBh
cmQgPG1yaXBhcmRAa2VybmVsLm9yZz47IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBz
dXNlLmRlPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9y
Zz47IEx1Y2EgQ2VyZXNvbGkgPGx1Y2EuY2VyZXNvbGlAYm9vdGxpbi5jb20+OyBQZXQgV2VuZyAo
57+B546J6IqsKSA8UGV0LldlbmdAaXRlLmNvbS50dz47IEtlbm5ldGggSHVuZyAo5rSq5a625YCr
KSA8S2VubmV0aC5IdW5nQGl0ZS5jb20udHc+OyBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgRG1pdHJ5IEJhcnlzaGtvdiA8ZG1pdHJ5LmJhcnlzaGtvdkBvc3MucXVhbGNvbW0uY29t
Pg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMS8yXSBkdC1iaW5kaW5nczogZGlzcGxheTogYnJp
ZGdlOiBBZGQgSVRFIElUNjE2MiBNSVBJIERTSSB0byBIRE1JIGJyaWRnZQ0KPg0KPk9uIFRodSwg
T2N0IDI5LCAyMDI2IGF0IDA2OjEyOjMwUE0gKzA4MDAsIEhlcm1lcyBXdSB3cm90ZToNCj4+IEFk
ZCBkZXZpY2UgdHJlZSBiaW5kaW5nIGRvY3VtZW50YXRpb24gZm9yIHRoZSBJVEUgSVQ2MTYyIE1J
UEkgRFNJIHRvIA0KPj4gSERNSSAyLjAgYnJpZGdlIGNoaXAuIFRoZSBJVDYxNjIgaXMgYW4gSTJD
LWNvbnRyb2xsZWQgYnJpZGdlIHRoYXQgDQo+PiBzdXBwb3J0cyB0aGUgZm9sbG93aW5nIGNvbmZp
Z3VyYXRpb25zOg0KPj4gDQo+PiAgIC0gU2luZ2xlIE1JUEkgRFNJIGlucHV0OiB1cCB0byA0SyBA
IDMwSHoNCj4+ICAgLSBEdWFsIE1JUEkgRFNJIGlucHV0IChjb21iaW5lZCk6IHVwIHRvIDRLIEAg
NjBIeg0KPj4gDQo+PiBUaGUgY2hpcCBhbHNvIHN1cHBvcnRzIHVwIHRvIDgtY2hhbm5lbCBhdWRp
byBvdXRwdXQgdmlhIDQgSTJTIGRhdGEgDQo+PiBjaGFubmVscy4NCj4+IA0KPj4gQXNzaXN0ZWQt
Ynk6IENsYXVkZSBPcHVzIDUuNQ0KPg0KPkRyb3AgdGhlIHRhZyBub3csIHJ1bGVzIGNoYW5nZWQu
DQo+DQpUaGFua3MsIEkgd2lsbCBkcm9wIGl0IGluIHY2Lg0KDQo+UGxlYXNlIHJ1biBzY3JpcHRz
L2NoZWNrcGF0Y2gucGwgb24gdGhlIHBhdGNoZXMgYW5kIGZpeCByZXBvcnRlZCB3YXJuaW5ncy4g
QWZ0ZXIgdGhhdCwgcnVuIGFsc28gJ3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLXN0cmljdCcgb24g
dGhlIHBhdGNoZXMgYW5kIChwcm9iYWJseSkgZml4IG1vcmUgd2FybmluZ3MuIFNvbWUgd2Fybmlu
Z3MgY2FuIGJlIGlnbm9yZWQsIGVzcGVjaWFsbHkgZnJvbSAtLXN0cmljdCBydW4sIGJ1dCB0aGUg
Y29kZSBoZXJlIGxvb2tzIGxpa2UgaXQgbmVlZHMgYSBmaXguIEZlZWwgZnJlZSB0byBnZXQgaW4g
dG91Y2ggaWYgdGhlIHdhcm5pbmcgaXMgbm90IGNsZWFyLg0KPg0KSSByYW4gY2hlY2twYXRjaC5w
bCwgd2l0aCBhbmQgd2l0aG91dCAtLXN0cmljdCwgb24gYm90aCBwYXRjaGVzLiBUaGUNCm9ubHkg
cmVtYWluaW5nIHdhcm5pbmcgaXMgImRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8iIG9u
IHRoaXMNCnBhdGNoLiBUaGUgTUFJTlRBSU5FUlMgZW50cnkgdGhhdCBjb3ZlcnMgaXRlLGl0NjE2
Mi55YW1sIGlzIGFkZGVkIGluDQpwYXRjaCAyLzIsIHNvIEkgd2lsbCBrZWVwIGl0IHRoZXJlIHVu
bGVzcyB5b3UgcHJlZmVyIGl0IGluIHRoaXMgcGF0Y2guDQoNCj5SZXZpZXdlZC1ieTogS3J6eXN6
dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBvc3MucXVhbGNvbW0uY29tPg0KDQpU
aGFuayB5b3UgZm9yIHRoZSByZXZpZXcuDQoNCj5CZXN0IHJlZ2FyZHMsDQo+S3J6eXN6dG9mDQo+
DQoNClJlZ2FyZHMsDQpIZXJtZXMNCg==
