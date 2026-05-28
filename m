Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0387CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 19:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3527B10F5C3;
	Thu, 28 May 2026 19:22:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sl33tTDZ";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011065.outbound.protection.outlook.com [52.101.52.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 193B910F5C3;
 Thu, 28 May 2026 19:22:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mi1xf7GsXnTqGcT1eWs+DY8LUJrGl4oZswJgSmEu4h8OtQXjwsnx+94yp53CCqPgtmEgO4mhLzpb4MRR7bD5Elk8ib5mjI/X0yzMeVlWWO9IbwPsz8qB1ZnD2Mn289YMo6dAL0DDWDa4G70P1uikGdYuOjHFCgEszjuTko/S+udwXTSyi5G1yv1DwRrIwovEF9pVlRPaMq4ftMYKGHfF/oHi6wheEOXTKNJ0hSGqntIarFoAtkhG+NTnBS3NLmk/JHB8AhD7Eh0fy9x76WZuv8q6426D8rf+0mmIscd2XdbKthZtRcFSXrp7kcVB+wop+4IZ06DdpRlwSzZAx7yEPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlKSe+jkDct0RgF/uXGvg+6AnaN/42RkF+0g/Pr/kUk=;
 b=DQPN4AHCpv36uCm1hti39Kjcz3c6EDouhiaXOXzzjEGiy+kOBsJQ5OJ9nie+O1Z1/NiOaygiTqVWgjOGdNzgucm8RXGnEff4pyLH8t4CRjy/DrkVOhy0lHnnqgNkogYdRmN7wbtkgaewELVUMM8vn/Npk7OzwN6nTK6V30FafEKIzVoXTbkjueufe0dIP/g4UvdJP4cqrl6NAYyaqb1dZ2paxZZI6JWpHaFZhaEId4POUYL1QB0DFMEOwX5sSWG6iT2GvKDWbSR0z/RuCP1MBbAdPeJNNrBCuAXqH9ne//s9cgZE8dIhQRFbGyysm+uqP+RBm421+fh3CJKWBpdd9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlKSe+jkDct0RgF/uXGvg+6AnaN/42RkF+0g/Pr/kUk=;
 b=Sl33tTDZBVDoeS49HyOXznNE6QgT5h3xJIOCjWkpi1e+p1zSmEdwcw8klLrU+ElWis8cTJkXoHxWVAUXXp5IjMByh9EvefcQJDLjYwjrHUIFz4/wQvnEcxyW8ofHYagHttWq60g6UJCaxOmvZIOv4ggsqmRLvF8U8WMvJiKesxbgE43BqxB628I23wPSF5TkZq3qjw4nv2WCCwSeypA9ST1wJCjjN5rktyTbIQ9RuZwKjHqyeFuQK+DF9q7zV17Sk2l0NI9ck7aNWEv5Vh2kSDjao5D09WkxDiUPR4r4OCwxZp4nP0Yn6zwtz5cmdF94wWNfRIk0qh34Jk7BAVSLyg==
Received: from CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 by PH7PR12MB6633.namprd12.prod.outlook.com (2603:10b6:510:1ff::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 19:22:37 +0000
Received: from CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970]) by CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 19:22:37 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "lyude@redhat.com" <lyude@redhat.com>, "dakr@kernel.org" <dakr@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "airlied@redhat.com" <airlied@redhat.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "nouveau@lists.freedesktop.org"
 <nouveau@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "zenghongling@kylinos.cn" <zenghongling@kylinos.cn>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "bskeggs@nvidia.com" <bskeggs@nvidia.com>,
 "zhongling0719@126.com" <zhongling0719@126.com>, "mripard@kernel.org"
 <mripard@kernel.org>
Subject: Re: [PATCH 0/5] nouveau/gsp: Cleanup IS_ERR_OR_NULL() usage
Thread-Topic: [PATCH 0/5] nouveau/gsp: Cleanup IS_ERR_OR_NULL() usage
Thread-Index: AQHc7mq8OsOwNXpeJUCGv9myN2oJCbYjpM+AgAAU9gCAABN1AIAAAQeAgAACvACAAACJgIAAAFIA
Date: Thu, 28 May 2026 19:22:37 +0000
Message-ID: <5d385e2828f8de93c40270d04008de3743b39bbf.camel@nvidia.com>
References: <20260528062451.54107-1-zenghongling@kylinos.cn>
 <794dbd35fd81f03478cdd3238d3d506d0d800187.camel@redhat.com>
 <DIUI56CABZAF.3TU7XCIKTV93R@kernel.org>
 <ad1ab3a555ca34f37ca4d7c20af5f4cadc4558b5.camel@nvidia.com>
 <c45c2e9096df0b407fa67ee5caee6b4641e2c8ab.camel@redhat.com>
 <6f1e4f968777c0e78b2bcd1c3ef2812b28a0ec41.camel@nvidia.com>
 <3c74f55d233e1607d2b427f758ed01b2694fb704.camel@redhat.com>
In-Reply-To: <3c74f55d233e1607d2b427f758ed01b2694fb704.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-9 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8412:EE_|PH7PR12MB6633:EE_
x-ms-office365-filtering-correlation-id: eea55c5b-43e8-441b-8181-08debcee7a57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|56012099006|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: YAfSdOhNA6aInsWZtYxkMU23WR1vy2mZ60WDYn+T4fMAstCx4fGS7+JjKKWzYmhn9K3w7wqA0H1ux9Dxv189OX6ojW94bXpwBqSnbCQNRHhgHnNJMlQJTgivMzYa/c2h0NZ12llMAy2Um3LwI7OkeLKXzvNk/YWZxzX7cbil6L1bHtZY7BT7bst9u/JwtOI7OvHyafpnFWP9lRa+Byeg8GUPtUoGBd5V9bXfGCtcHdOk9tZBEM5gfIrx6YkMORiZtdbMNmFh1MsrXP7y05tbcg7eCJwCdBS1P2elCh5QNr/3ojcG93nBOaIVLvFrKnNZWAoPKl1F2S+lwovGVYrxi2UVwI9GmQeKnxWV4rsBq0zhyuHSqVJgZ0HIBQEU9tQ4RSmxrPoJEt1vawUd6ArSpK0B/K9ptcuoFTAFCDDrXVpv1i6jqhMwHKwJeyVdG8PQH5O5cGtzg3xfT2hcxQHBivVoWpNaPxTvFLBHMldtUxRi2MBKYLAzG7AiXi1E0/yeU1GsjPdRC4vhNLrg3P1CZoZar3X76GOlPRsSWd+grHLg3zIxihCi3liCTEqYeb9Zfq/NwXkvrRM9EOcz19ulb02GTiCnaOKqYocoUS4U9KzzABreQ6ffgOiVjL1uZc9Cl9+iqSjCa6pAuI2n2WTHYyAKNxhvS+yhS0ckzTnPS76sC3JZZze3FQoiS7MfazrBNddaFsc6k+2SADeTFIdcj9DARvFvGIn4KyjVKxrSDWPXP2nrL2VRtD3pWM9xsphf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8412.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHdjOVowNmdkbE1ldk10ZGZtK1huTjJDUmxGYkNrZ2F4VjhEbnp0TGJVQWlQ?=
 =?utf-8?B?bXkveFZIajBkZStBL1d3NERwYXNBRk00bk9Mbk1IaCtTZzFCL2lLYlUzbWJt?=
 =?utf-8?B?TGNzYWZIZWRNVzEwa3lNajFDbEtUd3RVZS9XaFJTNEY3RnQ5UFFDZjNEcDNw?=
 =?utf-8?B?UFdVUHp3N1d4L3pJWTZYVXBpWkM0dkVtSUFQVXd2Ny8yRkUxdWFVZTJtY2hz?=
 =?utf-8?B?Rmhsb01KR0QybEVVempLenRqTWxNamhtMk80NGtWSlMvOVA0ditsTkRuY0sy?=
 =?utf-8?B?V1hhQXVUT0kzSUpVS0xSZkI3Y3p4NGx5QlU4UDIrY1BBdkx0eEwxRktWQzYr?=
 =?utf-8?B?bkVHdWVkQXh3dHp6Q0FyRDVLMWorTVFMRmdxY0dPelJpT2hnc1FQYmpvRk10?=
 =?utf-8?B?QUR2YUVCUWVrclIxdFRMSnRTNzNkcVJqUE5aMk5FYkExTDlmR1loVnFnaWpu?=
 =?utf-8?B?Q3Y0NjcyMHF3WkFWeUxFS1ZURU5vUzJnY0IyNGl6bk04SUQrais4aGtCRVFi?=
 =?utf-8?B?cmdFQzg1RUFpVjhBSFdTcEtTMnRqN04yY3NidTI2a2xyYzZna3ExbHZvTUwv?=
 =?utf-8?B?dVZmamVRdW9JQkI1QkRwZ2xMRjhieGZMOHhEZzJtd3JLcFExTXJidG9qR2g1?=
 =?utf-8?B?V3ZvN0E2UEZra1lTR3F2OU5OZkZFdklETkk1L0pZRlQ1Y01iRUQxUDlCb1dU?=
 =?utf-8?B?aWJCR1FKemtodHRwaldjZTZmSXlkTDd3U25IT2ZwTlpOanE1VDFvWXI4WHdG?=
 =?utf-8?B?cGl1VTBzaHBxVnAvdGZobzl1VzRnYThDNGd5dmtEMi9UMWRZYW1sMHNHYW1R?=
 =?utf-8?B?Wk9QNjBiMFRRdkNub2ppWGZsVFRIRCthbEpXb2c1bjZmL0VpT1N0TEdrODJS?=
 =?utf-8?B?N1BIdmFVREYrcitUOFZZSU5Mckk3alRZVjFCT3BrWXNRbDZNMTJrRlFpWitC?=
 =?utf-8?B?V0EvaitqcTFkUTNrNDNRcFhwakNMK2dObDlHUmUreUgyckFzazFubWQzbUVy?=
 =?utf-8?B?QzIwZldNRmY1a0dZVExDREpWRlUySWV4WGIrTVl6SFJjVWJYVlBZWHZWYWVW?=
 =?utf-8?B?ek1EcEJCSUpCeEpQdzc3NFB3WFBiYTY3R1YxSXZBYUhzd1VGcER4aFlqdU52?=
 =?utf-8?B?WlNMeFVpUTY0T3BCREU3elR4UlFuSTNMakRvc0NQTlpBQmNvSHV3bllWNFFl?=
 =?utf-8?B?T0JOeDg4MlloRWx2SG80SU84SEx4RFVzbDhOc1NvUG03TXlwZC9CcStHaXVw?=
 =?utf-8?B?ZVM5VnFTWVNYcy81ai85MUUxaEFja3hhMWhkZjRDMVBiNUZPdjdqNmR6dE93?=
 =?utf-8?B?SnozK3hSdGJTZXc3d1gvL3g2bm8vaFllb05uNkFiYXZIN2VMc0lEMlJVbGdY?=
 =?utf-8?B?dGlRSDV5b2QyREdLQlY5dnFnTHRwaGlBdXdLSi82MTJUYkpvTndiRjRNOFh6?=
 =?utf-8?B?bTh0eUQ1dGhaNkNlR1lpeVhQSVE4WFIxQzdSZGlLcWQyakhJUk1oSWFLTFZm?=
 =?utf-8?B?eUQ0dG5aY1g2cmtIUGNHczk3T0MvK3JXQk5Cd1JVeTRDUmFDSTVDRnNuZ0ps?=
 =?utf-8?B?cWZycWMzazJUand2Ykt4QzhPdmcrVlY5SHRibmVWVjhpSXEzdHpjZ0N5UElo?=
 =?utf-8?B?azRVM2xKVkI4WHczb1VTOHhENUQ1YlZlckFyU1Evclh5QVFwMm1xdVkxekdZ?=
 =?utf-8?B?NkxkYUR0SFFxY0xsOGpha2ZwU0xoMXo0NjlpTXNXY3l4NFJHQ084SjVVMEEr?=
 =?utf-8?B?NXNxWkxReCs5WitRSmRqV3dJeVRIL0l5NVhHcytkOUxaOVZlK3ZOM0VpWGxp?=
 =?utf-8?B?VGx0NHRDTkd6S20vL2VReDdUSThWbWdoZnE4SkdLdWV0QnlPWkN2dHlKdGtS?=
 =?utf-8?B?TmNzZ3JUQm5KNXdKR050UURFaUVySGNlV1hzaXVVTFV4OGZGaGNkcm5ya292?=
 =?utf-8?B?MnZBV0FiRWVRSkFkUGlNVGlHRGF6bnJHVW56S0dNSnl6cUt1OGZWUCtXSW5w?=
 =?utf-8?B?aTg5eUpmNWJicDhVL1JDK2F0QlZnS0FRS0kzbXYvVWFSMmRNTmE5UzdJM1Fw?=
 =?utf-8?B?QXF5UVVDNEdUT1grQkt4bzFKT1hFaW9oN2J4dHpMajI0LzlmamVPYk44ZDZo?=
 =?utf-8?B?U2dpMTFvTGducjRrK3RWYmJjdVVzWk1VdlhhUGRRSVBoV0t4ZUxGUVdxTnFW?=
 =?utf-8?B?UDJCYkV5MEk3STZmNE41eEl1cWw2Vlc5Rk9heWZOdnJTMmtrSjFyQVNzOXd0?=
 =?utf-8?B?c29WVnd1QlNNZjJMQzdiSU9wRzgwbnBhUDBnNVFIejFWbEFEZ2ZQWDRzMTFV?=
 =?utf-8?B?L0wzMllaUkJjRXVCV2lKdytIcmZSdWJrenJocklQV1ZnTGFGbnJzQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBF4296FF9EBCC44BCD623ADEDB7FEB2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea55c5b-43e8-441b-8181-08debcee7a57
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 19:22:37.3602 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hePuEtntJPi+qEU9IsTpqtC3tNW57P1wew9fwGNAkHXxyPprRNcTHS+lztxeEMect7b9WTf20io1Y8BzyTHD5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6633
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

T24gVGh1LCAyMDI2LTA1LTI4IGF0IDE1OjIxIC0wNDAwLCBseXVkZUByZWRoYXQuY29tIHdyb3Rl
Og0KPiBZZWFoIC0gdGhhdCdzIGEgZ29vZCBwb2ludC4gSSB3aWxsIGdvIGFoZWFkIGFuZCBzZW5k
IHRoZSByZXZlcnQgZm9yIHRoZQ0KPiB3aG9sZSBzZXJpZXMgdGhlbiwgd291bGQgeW91IG1pbmQg
aGVscGluZyB0byByZXZpZXcgaXQ/DQoNClN1cmUuDQo=
