Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEF4CD98F6
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:19:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7635010F532;
	Fri, 19 Jun 2026 11:19:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="qc1X2MoA";
	dkim-atps=neutral
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011030.outbound.protection.outlook.com [52.101.125.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F10310F532
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 11:19:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h56FdIdUilU/QbwRAfA1w6tvJJBPy0txOFV8FVTDZra913E4bshWvICHLFD3yugtlKdh1c9ACCbjPp1t8ivztEg4+Nm0VGCL4wal+4/mSgj20UZIuh8vrfny37tiMJMsNvnbjpsDsENvQ8iEBjlQoCpMHa0PrXg+MOIakcMSyDKn9Mn51CLuIBo3HjwmcXEwlfzxdCQVxaj5IdeXt9PzcqRXcLQDyZo4m7tgX+XgSZP+rxuQ1mg75bNFd1a8Wy6g2nw8xJnmj9afOcF5KELIRQHd25iZ+Zm82UqYBvnoIvlZCevqLx0lRIteRs2M1vjHxYRoEk9D05nB6WboNc/VFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECD+zLo2PAKxbIbQgiGXd/Qd9ppD+w/8cfOG85NOTdg=;
 b=eeW+cv8UUa6Bfg2BxxzKNyAnc7oELQmC4GYKm5EZ1dpqBgDOJ6CUWpodCXn1Hb+af7XUdYrjNRQrDIKzrSfGiDfJ2c+jIDXSIiWIVAs+vxkwALvq5BL9GHSDYzZGoI40wtTnbFdWjx+HCmXDDmLduUXB3o5gLgAsTpr4aLzGUxyoUZEV1Sa6JY/IBxqDz4leLKfprev+adeaODs5AMS9zOeQTkv8n86T7BQa85/PyAtY0mAQEXVCwjUdgr1L+5A5SnHFiGIj93yPn62TQTOF9eYiqrP871hB82tkHYgPUl2Bt9AMpkqrp1TEwnxggqrYwWn7J+2eXsQ+sH9L24w69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECD+zLo2PAKxbIbQgiGXd/Qd9ppD+w/8cfOG85NOTdg=;
 b=qc1X2MoAn9PCNjjPdJMGd6G1dYFBr0I67cc/hPsiIAqnmFIdeNe3f6868XUKsRN+1chkjATGw3whYiZ6HDt6oYm5mlvH87jWAQnpZbla5V3lN1kTnBY0ECWoBHH6DsPEPlR1MPWlMUZY0yl3VscYqss6blUA3sn9HU0/ZYuAvIQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB11573.jpnprd01.prod.outlook.com (2603:1096:400:375::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 11:19:29 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0139.011; Fri, 19 Jun 2026
 11:19:29 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
 biju.das.au <biju.das.au@gmail.com>
CC: wsa+renesas <wsa+renesas@sang-engineering.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH v4 2/2] drm: renesas: rz-du: Add support for RZ/G3L LVDS
 encoder
Thread-Topic: [PATCH v4 2/2] drm: renesas: rz-du: Add support for RZ/G3L LVDS
 encoder
Thread-Index: AQHc/9Pii3urZfxKykKYlbMUYRwKELZFqscAgAAOkAA=
Date: Fri, 19 Jun 2026 11:19:29 +0000
Message-ID: <TY3PR01MB11346313C972E5F48834BD5A086E22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260619101026.323633-1-biju.das.jz@bp.renesas.com>
 <20260619101026.323633-3-biju.das.jz@bp.renesas.com>
 <20260619102014.990C71F000E9@smtp.kernel.org>
In-Reply-To: <20260619102014.990C71F000E9@smtp.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB11573:EE_
x-ms-office365-filtering-correlation-id: 5538d5c1-51bc-42a7-6f87-08decdf4a14d
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|4143699003|6133799003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: xV0ePYD9qZ0vgyNsCww2R2RIJGGSF0xJwZ5c0+VCXARKihk4HTfPAWp9+qRVn0O4k3qsv9rmA5JItEBr/9OPS30qQNTLs5VVTpcdaUWt7GuVyXix7OHHRdMInubs24TjMCyetYxP5m3kx995ob9ELE3RmKWLTDlGmGl2lqSLxL/6diae7a3qEjLshZny556EvHsyeedW/y5EIMgbjd/WOFJHi3BlClQHFDLwFa1G8Pu0DcFKMbfbIub0Rt+mpg7tf7CVgWwgTqmN11a0bWDNm/NugoVEthb+AKpE9H2Gur3n1DmYO18OCm7iaFuicqiVUpTPcd5dNL9v8BJxEWeeA6nItrQppB216vjQnmpdB7nFOoynfphoyp2WdmZHI61K8DxN6JPi7HAY7Oon6HDvoAqvh1j7wdjaQ39Fuy7Pu5Dp+jxTBsQ+lAzCjnTLWFA355LSCEew1nFNcChadBdq3UnRYCA4+DiMQSsiER4W+jxAliHFJVBCzLbNeTTBqdzs2CDbUG03NsUbJ6e5WU5/Kju1p/X7lToDCBE7Y5+1gQPqzhP6Tv4hh6VZHD/bYmFOSO9SfTVwkJ7e3lTXk9ydLT4lwkNph+7yCQuvwXXORUGqKziO8iIzYPnhbmVzIsaV+/5Vaums0lQYFzkf2JOeA4ajqbDMJxjKk6PdI5S50d6Gm8UQolHYJAtrtmDNZOS1UnKDVCHrDZi6PB3R5UjcW2tJgnnJKwHKQZGly0xIxsY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(4143699003)(6133799003)(38070700021)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkFmUXFSYmRnRjRLZUZmcGRzRmk5aGFsV0FQVTU1QkZudWFCc3BUa2E5dlNZ?=
 =?utf-8?B?ZThwSFUzWFpOZE01RUk0eTR3QlZwNFREaXFNZjlnZ1NTSVloTmx3ckhWZjlP?=
 =?utf-8?B?M2FSOFZ1bFltSVJmdXhFYzdGVzZYZXBPcHlML25jUXNJVXkrYVcvcGV6L2Yr?=
 =?utf-8?B?ZkZSTmVjdWFLaXFxeWlqbm0xK3VucTBRM3JVT2QzSUJSQTdodTAzMk12REh6?=
 =?utf-8?B?ay9FeFlwTlAvU0JCbkpoMGVaOG1OclRZMjdPMU1BbHBwUDJMclFZRy9TV1dw?=
 =?utf-8?B?U0pqcnExczJLazRYN1JQRDZjTEJrNGZiVUhEQTgrRi9FMldIRzRlQlpVUG45?=
 =?utf-8?B?c1ZveXJTa3BldVZYZ0xwK3R5SzI0NlA2T0pQQnBmTUM0U3NPQWxuT0ZXeXJO?=
 =?utf-8?B?bkRkS0luZGFjeUZPZUhtZkRNaGtJeU53T09VUzVUNlAyMHlaQ1hHV1dnemFh?=
 =?utf-8?B?ZzE5dkpRakEvSm5mQzdPa0piY2luZWMwVzNFUjVBZ3VHV3FMVlpUeGhzVWJZ?=
 =?utf-8?B?dHRjN0pwK2p2T1RpS2hrTjcxSFVuRGZKb2xDajZMREszbWFJbGZEaklaRHl4?=
 =?utf-8?B?bGxzTzhxVVZVTDZtT2NJMUEzSWxWZ3BVUkpmUWQxMDRVcjFlbUdpejQ2WE1B?=
 =?utf-8?B?c0VDWWFvZklaajk2RnYvY0FRbFhhQSs4OXlxWmZuTG5Mb1M3NTFmV1JMY21n?=
 =?utf-8?B?dWtDUU9OL3owbTJ1U2QvWFZ4L2Z2U3pvMjU5elcyUlgyTjZQU1hpTHFocVh3?=
 =?utf-8?B?Wk1JZm1LL2o1UnF0T2JHQ2xweVU2SjZvalB1cXh1NXB6SzJ4aDRMR2pMUkxs?=
 =?utf-8?B?U1BGUTZHWE56cU9LaExseTd0OFVOeEQwSjA5MjB2bXlCb3c5ZTVoazFqUUdT?=
 =?utf-8?B?RlVBUTVLd3dxc29LYXVIYm1Kazh0UEVuQkkvZTBJTmpER2ptM0J1NGlDMndt?=
 =?utf-8?B?dWNKWHRsZE9MVlVQWis2R2E4RWlocUNPdUQ0M2dlUlJlcWx6S2xDTytnS3Ri?=
 =?utf-8?B?QnluL3ZoU1UzMVFzeTZjNUtWSHBvdTlnYkhWVzdFQ1ZqMFFjcmwwaGRMQytI?=
 =?utf-8?B?UGltajJGUGJpNmRMTlhGd2NxOGd6ZVNLQmRqZVRmRGZ3NWQ4WmV4dUVxcDJi?=
 =?utf-8?B?dW1BTjVxUVZSd0k0YVBWeXdXb0U1L01OQUFHcVo1ai9ERmkza3V6NDM5cVlh?=
 =?utf-8?B?Vk5GdkhwME5DOXE1dVpnM0NnSkQwVjBUTjNXNE1KVzROSFVPb0lPS2hkbndw?=
 =?utf-8?B?a1JQQjJ1SmJPVUdRTkszTkYrb2tGVGsxNkYzbnNNZUZiNVNranBuamFRT2Vw?=
 =?utf-8?B?eVNHeE9WaWVCRlZqM0RRN2hMbExuaTZoejZxT1RoTzd0Lzcramw3bjNQdGR2?=
 =?utf-8?B?SnFUNnlPM0E2TkZPd2Vrb0ZtRFY5bHFNYUxwYmh2WFo0Z1Z0NkNxSHc0VHhY?=
 =?utf-8?B?T0trOEY2aHF3L0tlYzdZcTFaa1ZDOEEzL2M0Wi9KOXF0ZFd6TzhHQmtobUF0?=
 =?utf-8?B?b0tjZXMyY1BaM0JsS3k5ZjFFc2Nxcm5yUUxhM1Brb3o4YUlkSmd5VXFUREtx?=
 =?utf-8?B?Y2F2TGl0VWgyVVZzelE0YmY5eDRScmtlRmkwRVViT3U1cXlLMHlPZ3p3dVlO?=
 =?utf-8?B?VVJLRk1JVTI3UllrUlBOamlRWkJlNnoxdklmbEVPNytLbTBhNWJJc2dibHJ2?=
 =?utf-8?B?R1RxNW5pamZLNGFXTWs0L0pVOHRPek9KQS8rOTR6MDBpUitBK1ZEV1ZlS3hj?=
 =?utf-8?B?MzhTYkxqQ0pkMUVZeWljdEJhK0xPWFJScklmcnNiMXJ6U3VPdlRHT3NVVVI4?=
 =?utf-8?B?ZjQyRTZ3RHlvTmdjQ0ZRUUx1UURlaitQOTRlTjBCM3ZXd3hCL2tlR2dLblhZ?=
 =?utf-8?B?WjVLeDhNdlVQOEdSYXZCS09vb09VdXVhcFlybWtZQkZ0YUpkR0M0MVZzMWRx?=
 =?utf-8?B?RFJ3OGlXaDdvajBrdGppZFpwTEZRRlRDcjdNT0dzUVc5RVpZaURRcUZnaVlM?=
 =?utf-8?B?RU5Pa2FmTkxVRlJIUFB6enpQeW5pZnZsakhWeHJpclBxOEdVKzJmU1RBOTVG?=
 =?utf-8?B?NWdDeXNnSG9mVVpXL05ieldhZHlNNCtGbHpSeDFPdHIzeEtNSlgwOVJLcDZx?=
 =?utf-8?B?VklSZ2VmMzBIK0VMUDA2WGRCYXd0bVE0YmpMZSt6N2FrbFRXb2RRN2dLdUxC?=
 =?utf-8?B?QjNRaFJQd2NDSUlhUlNqNE5kUXkvbmhOWlJJb2VoY1RoLzY2Qlg4M1RDVDdZ?=
 =?utf-8?B?K3dCRGJiekc1eHNSTWRPdmo0RlJrTEhPRmlQZmxJd2orRng4NFhVZkUrdGpW?=
 =?utf-8?B?bWUzK2htZmdUK2pPeHFlaU1xTEVzSlBPTTZLZTF0R3R5b2FBd1N6dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5538d5c1-51bc-42a7-6f87-08decdf4a14d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 11:19:29.4522 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2AJEu36Oqyhuh53uQQibe09hTZ4UdGe7FYhcbItxpn2bjflBVQE7/UT83nt7FfoTLDzC4s1AaMJZtuSlH5/09gWeTM681Rb+1mBqvLsON7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11573
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

SGkgc2FzaGlrbywNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IGRyaS1kZXZlbCA8ZHJpLWRldmVsLWJvdW5jZXNAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2Ygc2FzaGlrby1ib3RAa2VybmVsLm9yZw0KPiBT
ZW50OiAxOSBKdW5lIDIwMjYgMTE6MjANCj4gVG86IGJpanUuZGFzLmF1IDxiaWp1LmRhcy5hdUBn
bWFpbC5jb20+DQo+IENjOiB3c2ErcmVuZXNhcyA8d3NhK3JlbmVzYXNAc2FuZy1lbmdpbmVlcmlu
Zy5jb20+OyBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjQgMi8yXSBkcm06IHJlbmVzYXM6IHJ6LWR1OiBBZGQgc3VwcG9ydCBmb3IgUlovRzNM
IExWRFMgZW5jb2Rlcg0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIGNvbnRyaWJ1dGlvbiEgU2Fz
aGlrbyBBSSByZXZpZXcgZm91bmQgMiBwb3RlbnRpYWwgaXNzdWUocykgdG8gY29uc2lkZXI6DQo+
IC0gW0hpZ2hdIFNsZWVwaW5nIGZ1bmN0aW9ucyBjYWxsZWQgaW4gYXRvbWljIGNvbnRleHQgZHVy
aW5nIGJyaWRnZSBlbmFibGUNCg0KQ2FuIHlvdSBwbGVhc2UgbGV0IG1lIGtub3cgd2hpY2ggaXMg
YXRvbWljIGNvbnRleHQgaGVyZT8NCg0KUHJvYmU6IE5vIHNsZWVwaW5nIGNvbnRleHQNClsgICAx
OS42MTEwOTBdICByemczbF9sdmRzX2F0b21pY19lbmFibGUrMHgxOC8weDE2YyBbcnpnM2xfbHZk
c10gKFApDQpbICAgMTkuNjExMTA2XSAgZHJtX2F0b21pY19icmlkZ2VfY2hhaW5fZW5hYmxlKzB4
NjAvMHhiMCBbZHJtXQ0KWyAgIDE5LjYxMTI4N10gIGRybV9hdG9taWNfaGVscGVyX2NvbW1pdF9l
bmNvZGVyX2JyaWRnZV9lbmFibGUrMHhkYy8weDE0MCBbZHJtX2ttc19oZWxwZXJdDQpbICAgMTku
NjExMzg2XSAgZHJtX2F0b21pY19oZWxwZXJfY29tbWl0X3RhaWxfcnBtKzB4ODAvMHhlMCBbZHJt
X2ttc19oZWxwZXJdDQpbICAgMTkuNjExNDU2XSAgY29tbWl0X3RhaWwrMHhhNC8weDFhNCBbZHJt
X2ttc19oZWxwZXJdDQpbICAgMTkuNjExNTI0XSAgZHJtX2F0b21pY19oZWxwZXJfY29tbWl0KzB4
MTdjLzB4MWIwIFtkcm1fa21zX2hlbHBlcl0NClsgICAxOS42MTE1OTNdICBkcm1fYXRvbWljX2Nv
bW1pdCsweDhjLzB4Y2MgW2RybV0NClsgICAxOS42MTE3NjZdICBkcm1fY2xpZW50X21vZGVzZXRf
Y29tbWl0X2F0b21pYysweDIyNC8weDI5NCBbZHJtXQ0KWyAgIDE5LjYxMTkzN10gIGRybV9jbGll
bnRfbW9kZXNldF9jb21taXRfbG9ja2VkKzB4NWMvMHgxODggW2RybV0NClsgICAxOS42MTIxMDhd
ICBkcm1fY2xpZW50X21vZGVzZXRfY29tbWl0KzB4MmMvMHg1OCBbZHJtXQ0KWyAgIDE5LjYxMjI4
MF0gIF9fZHJtX2ZiX2hlbHBlcl9yZXN0b3JlX2ZiZGV2X21vZGVfdW5sb2NrZWQucGFydC4wKzB4
OTAvMHhhMCBbZHJtX2ttc19oZWxwZXJdDQpbICAgMTkuNjEyMzQ4XSAgZHJtX2ZiX2hlbHBlcl9z
ZXRfcGFyKzB4NjgvMHg4NCBbZHJtX2ttc19oZWxwZXJdDQpbICAgMTkuNjEyNDE3XSAgZmJjb25f
aW5pdCsweDRmYy8weDUyMA0KWyAgIDE5LjYxMjQzNV0gIHZpc3VhbF9pbml0KzB4YjQvMHgxMDQN
ClsgICAxOS42MTI0NDldICBkb19iaW5kX2Nvbl9kcml2ZXIuaXNyYS4wKzB4MWM0LzB4Mzc0DQpb
ICAgMTkuNjEyNDYyXSAgZG9fdGFrZV9vdmVyX2NvbnNvbGUrMHgxYTAvMHgyMDANClsgICAxOS42
MTI0NzRdICBkb19mYmNvbl90YWtlb3ZlcisweDZjLzB4ZTANClsgICAxOS42MTI0ODVdICBmYmNv
bl9mYl9yZWdpc3RlcmVkKzB4MWRjLzB4MWUwDQpbICAgMTkuNjEyNDk3XSAgZG9fcmVnaXN0ZXJf
ZnJhbWVidWZmZXIrMHgxOTgvMHgyNTQNClsgICAxOS42MTI1MDddICByZWdpc3Rlcl9mcmFtZWJ1
ZmZlcisweDJjLzB4NTANClsgICAxOS42MTI1MTZdICBfX2RybV9mYl9oZWxwZXJfaW5pdGlhbF9j
b25maWdfYW5kX3VubG9jaysweDMzMC8weDVjYyBbZHJtX2ttc19oZWxwZXJdDQpbICAgMTkuNjEy
NTgzXSAgZHJtX2ZiX2hlbHBlcl9pbml0aWFsX2NvbmZpZysweDQ0LzB4NTQgW2RybV9rbXNfaGVs
cGVyXQ0KWyAgIDE5LjYxMjY1MV0gIGRybV9mYmRldl9jbGllbnRfaG90cGx1ZysweDdjLzB4ZGMg
W2RybV9jbGllbnRfbGliXQ0KWyAgIDE5LjYxMjY2OV0gIGRybV9jbGllbnRfcmVnaXN0ZXIrMHg1
OC8weDljIFtkcm1dDQpbICAgMTkuNjEyODM5XSAgZHJtX2ZiZGV2X2NsaWVudF9zZXR1cCsweGE0
LzB4Y2UwIFtkcm1fY2xpZW50X2xpYl0NClsgICAxOS42MTI4NTNdICBkcm1fY2xpZW50X3NldHVw
KzB4YjAvMHhlMCBbZHJtX2NsaWVudF9saWJdDQpbICAgMTkuNjEyODYzXSAgcnpnMmxfZHVfcHJv
YmUrMHgxMzQvMHgxNzQgW3J6ZzJsX2R1X2RybV0NCg0KU3VzcGVuZCB0byBSQU06IG5vIHNsZWVw
aW5nIGNvbnRleHQNClsgICA3OS4yMzg1ODFdICByemczbF9sdmRzX2F0b21pY19lbmFibGUrMHgx
OC8weDE2YyBbcnpnM2xfbHZkc10gKFApDQpbICAgNzkuMjM4NTk1XSAgZHJtX2F0b21pY19icmlk
Z2VfY2hhaW5fZW5hYmxlKzB4NjAvMHhiMCBbZHJtXQ0KWyAgIDc5LjIzODc2NF0gIGRybV9hdG9t
aWNfaGVscGVyX2NvbW1pdF9lbmNvZGVyX2JyaWRnZV9lbmFibGUrMHhkYy8weDE0MCBbZHJtX2tt
c19oZWxwZXJdDQpbICAgNzkuMjM4ODc2XSAgZHJtX2F0b21pY19oZWxwZXJfY29tbWl0X3RhaWxf
cnBtKzB4ODAvMHhlMCBbZHJtX2ttc19oZWxwZXJdDQpbICAgNzkuMjM4OTQ3XSAgY29tbWl0X3Rh
aWwrMHhhNC8weDFhNCBbZHJtX2ttc19oZWxwZXJdDQpbICAgNzkuMjM5MDE0XSAgZHJtX2F0b21p
Y19oZWxwZXJfY29tbWl0KzB4MTdjLzB4MWIwIFtkcm1fa21zX2hlbHBlcl0NClsgICA3OS4yMzkw
ODBdICBkcm1fYXRvbWljX2NvbW1pdCsweDhjLzB4Y2MgW2RybV0NClsgICA3OS4yMzkyNTFdICBk
cm1fYXRvbWljX2hlbHBlcl9jb21taXRfZHVwbGljYXRlZF9zdGF0ZSsweDEzNC8weDE0OCBbZHJt
X2ttc19oZWxwZXJdDQpbICAgNzkuMjM5MzE5XSAgZHJtX2F0b21pY19oZWxwZXJfcmVzdW1lKzB4
YWMvMHgxOWMgW2RybV9rbXNfaGVscGVyXQ0KWyAgIDc5LjIzOTM4OV0gIGRybV9tb2RlX2NvbmZp
Z19oZWxwZXJfcmVzdW1lKzB4MjQvMHhjMCBbZHJtX2ttc19oZWxwZXJdDQpbICAgNzkuMjM5NDU5
XSAgcnpnMmxfZHVfcG1fcmVzdW1lKzB4MTgvMHgyNCBbcnpnMmxfZHVfZHJtXQ0KWyAgIDc5LjIz
OTQ3OV0gIGRldmljZV9yZXN1bWUrMHhjOC8weDFjNA0KWyAgIDc5LjIzOTQ5Nl0gIGRwbV9yZXN1
bWUrMHgxOTgvMHgxYjgNClsgICA3OS4yMzk1MDVdICBkcG1fcmVzdW1lX2VuZCsweDE4LzB4MzQN
ClsgICA3OS4yMzk1MTRdICBzdXNwZW5kX2RldmljZXNfYW5kX2VudGVyKzB4MjI0LzB4NTkwDQpb
ICAgNzkuMjM5NTMwXSAgcG1fc3VzcGVuZCsweDE5NC8weDFjMA0KWyAgIDc5LjIzOTUzOV0gIHN0
YXRlX3N0b3JlKzB4ODAvMHhmNA0KWyAgIDc5LjIzOTU0OV0gIGtvYmpfYXR0cl9zdG9yZSsweDE4
LzB4MzQNClsgICA3OS4yMzk1NjNdICBzeXNmc19rZl93cml0ZSsweDdjLzB4YTANClsgICA3OS4y
Mzk1NzVdICBrZXJuZnNfZm9wX3dyaXRlX2l0ZXIrMHgxMzAvMHgyMDANCg0KSG90cGx1ZzoNCg0K
XSAgcnpnM2xfbHZkc19hdG9taWNfZW5hYmxlKzB4MTgvMHgxNmMgW3J6ZzNsX2x2ZHNdIChQKQ0K
WyAgMjM1LjI2NDI3Ml0gIGRybV9hdG9taWNfYnJpZGdlX2NoYWluX2VuYWJsZSsweDYwLzB4YjAg
W2RybV0NClsgIDIzNS4yNzI1NDRdICBkcm1fYXRvbWljX2hlbHBlcl9jb21taXRfZW5jb2Rlcl9i
cmlkZ2VfZW5hYmxlKzB4ZGMvMHgxNDAgW2RybV9rbXNfaGVscGVyXQ0KWyAgMjM1LjI4MTYxMF0g
IGRybV9hdG9taWNfaGVscGVyX2NvbW1pdF90YWlsX3JwbSsweDgwLzB4ZTAgW2RybV9rbXNfaGVs
cGVyXQ0KWyAgMjM1LjI4OTQ0M10gIGNvbW1pdF90YWlsKzB4YTQvMHgxYTQgW2RybV9rbXNfaGVs
cGVyXQ0KWyAgMjM1LjI5NTQ1OV0gIGNvbW1pdF93b3JrKzB4MTQvMHgyMCBbZHJtX2ttc19oZWxw
ZXJdDQpbICAyMzUuMzAxMzk3XSAgcHJvY2Vzc19vbmVfd29yaysweDE1NC8weDI5MA0KWyAgMjM1
LjMwNTYyNV0gIHdvcmtlcl90aHJlYWQrMHgxODQvMHgyZjQNClsgIDIzNS4zMDk1NzFdICBrdGhy
ZWFkKzB4MTE4LzB4MTMwDQpbICAyMzUuMzEyOTgyXSAgcmV0X2Zyb21fZm9yaysweDEwLzB4MjAN
CiANCg0KDQo+IC0gW0hpZ2hdIEVhcmx5IHJldHVybnMgaW4gYGF0b21pY19lbmFibGVgIGNhdXNl
IHVuYmFsYW5jZWQgUE0gY291bnRlciBhbmQgdW5wb3dlcmVkIGhhcmR3YXJlIGFjY2VzcyBpbg0K
PiBgYXRvbWljX2Rpc2FibGVgDQo+IC0tDQoNClNvIGZhciBkdXJpbmcgdGVzdGluZyBubyBpc3N1
ZXMgZm91bmQsIFdBUk5fT04gaXMgYWRkZWQgdG8gZmluZA0KYW55IHN1Y2ggaXNzdWVzIGluIGZ1
dHVyZS4NCg0KQ2hlZXJzLA0KQmlqdQ0K
