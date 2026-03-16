Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F017F53D7E
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABD0C10E3C8;
	Mon, 16 Mar 2026 18:34:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="LIIBM8xr";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C84E110E3C8;
 Mon, 16 Mar 2026 18:34:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uy57v+nKyoioGuZAxBOaTNf8eoHjHYvYMqov2Vri3yZyIpz1f2WYq72f0jpE/CgrnmbC1Ea8KpMluaQuCcCFCDIL+4T0/MH3ens7GUdmwAl2WjoVIqMiRuMBLFMX4fmXNmJUrQsRrwUXOSP4mmTe9d3/Jp0K08w5Ipwy1e8vAkaqW23rCcbcZXmY1lR9ItIghajAc3q+Y3KEOzOflf0l3VZ7+yMt2ty9xzRv8y58BNnZyO8oeC9vls+YSrQdihgvTcXkNh5eHW2/pwS9JWUeVquaZrvTwSISJ4qSCD4eK3l+qruDX7etzlpbsz8/W8hVbBJzmpOTe3FiYhuJU8dVCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqlPW+whvThe1ITIKKVYNkcwWT7u3QmOtaBoNZ+NY68=;
 b=cDKBWnKoKO/SEymqcVvNE0XtWxU5U+FXzlyHoGunFQ3/s8LGEJKrnbgBemmljElNPo0ORV9jfTP3hmKAiXY9XtiqAY2QLUFpY04la2NqgqDi/s5QJqxuYk629bYi4a3uUBjwFYATmFvqhzDwfdYzTIPIQH7j4ceZ7BGA7LWcdDSp5yJ9y06tgciB2sPTxn8nPIoBaomOVeQ14e+yHa5TckUSn/iOcE6MoGseGGF1XOaTmyUCH4m34BbZpa+gXVMe6iB76semoQiuZ1kMQKhXAFLVWV0hbwEL5Ci/LRISXbiqlUPifoV/rfbdt45Y1qTWpy07N0WT8rn9HvUBshAEXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqlPW+whvThe1ITIKKVYNkcwWT7u3QmOtaBoNZ+NY68=;
 b=LIIBM8xrbIBwMpBpV3lIRpi5BGwonLdD+vAcvSAqi3PmdvmzeeqHsD++Ym9b98/bzI5rzSFtEMxZ5kcRvR9IdC1CXm97tmbUdG0o8bxXHUyvIHvv+YJhH9ilRXYQZBAatWxodfpSynRpfdbh17nzd28gIP3FUMsTAy+9vEv4Md0V1Y6IJcVRZyJPOTmrz9Txcf9GQjwOn97UyQIjfgec017b4jLuNNPfMhJJP8rPcVlJwOMvvh7HA6QSt+sO5jyNf7P9Padyrt7lntJIySbS67nhPHsR3YhgbQpKgxkFAPEN11PknSA/PQqrxfl5dDuQ1Qj0U5uySfuFZixYNOqHTg==
Received: from CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 18:34:12 +0000
Received: from CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970]) by CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970%6]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 18:34:11 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "sdl@nppct.ru" <sdl@nppct.ru>, "lyude@redhat.com" <lyude@redhat.com>
CC: "simona@ffwll.ch" <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "nouveau@lists.freedesktop.org"
 <nouveau@lists.freedesktop.org>, "lvc-project@linuxtesting.org"
 <lvc-project@linuxtesting.org>, "dakr@kernel.org" <dakr@kernel.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "mripard@kernel.org"
 <mripard@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/nouveau/disp: Fix potential NULL pointer dereference
 in nouveau_dp_irq
Thread-Topic: [PATCH] drm/nouveau/disp: Fix potential NULL pointer dereference
 in nouveau_dp_irq
Thread-Index: AQHctWt7u0x4fYncpkuCpyWLDhh4RrWxbc4AgAAHX4CAAAbxAA==
Date: Mon, 16 Mar 2026 18:34:11 +0000
Message-ID: <7ce43f76b51fb5f4d267cf95b935405fcd54fa8b.camel@nvidia.com>
References: <20260316172631.82304-1-sdl@nppct.ru>
 <ac4867a4c6da6aef61b189960c0142a660b2122b.camel@nvidia.com>
 <4dcb40c5-0a11-4e25-822b-98f5883751aa@nppct.ru>
In-Reply-To: <4dcb40c5-0a11-4e25-822b-98f5883751aa@nppct.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-4 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8412:EE_|SA1PR12MB5671:EE_
x-ms-office365-filtering-correlation-id: c665397a-3d78-41d3-155b-08de838a9e54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|56012099003|38070700021|8096899003;
x-microsoft-antispam-message-info: Wv3xw0EYrwFIUoqDwNVYttgdCejHRNAQ4jkyVt/avaeMYCNtTT5KhoXTjTNZqsnvQlsPDwcgVrPOsgEYaozIiYr6HrT0lNuoVajPl1dEQ+PBLm6aejZVx7hqFb2GC7xffq56951S5jpip36VLZ/sEoOvYcHWOb39KZ4mLhuz8KANdbucXfoJezXRsJJQNK90FBnO9XsyeszegqKeaw+9YDjNbTCM6Z36/ca494KjZLjRShxB0VoYwOWyhM7fVg22Een46ttsa8vIY4YiGfsg/Jt/f9e7x7+p6UNCtBty1c5cDpBMO1jKeJRnmF7/sd4LkxrRD8V30+ULotqHGHsjKTMmPUyja+FelwBXaGw3gQ6FIP/8iO9P4n2XBnJTQRxm2iu63gJ+R+UiJNxqjAmC6Q8ycr6NC8b2N/hH8RQacM5/Yf3XwxFO9JtcwW7HusJaHvhUlbMbNsiLq1TL8vDOoO8lQV5FN+r0M1GlUDvqgvkYtmnbxZ5pIcQBkw5LB+CR54AVPcFz76QJOMSepyXKG1HChhExltAuu6PlqRgh6zw5ICg955ibpwi21/PRuFpTHnebN5hLZaXXwc23VIV2Q8Xl1c47PDaO4gDLnvdEVZgK9IZQ/UUZXNi8YKEiIvI3TkomrxB+gOHgHA39iEQw06ThgHJTqcS+6iBJkbAerEpz3HGnQAOMOV5r8yI4f+Q2+xGog4bSDyG+7mHn20wjdhchLxZb1jkorf9CQie9B7jGwdBdJrUo3XUOHDNICRriTVVDIlXlNBF20uS8WaDVBkulU8g+PInj/SiFt2uDvxg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8412.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWxCMk5DeWpIcHlNNTJWaG40cnZ3RW5MdTlaN3RWWWVwbnl5emhoSS9yVlpI?=
 =?utf-8?B?RjUwWWllVW9RNnZzN3hzRGlsSWVsbHhpdnRqWDJtZVA4QXRIUjVwclgwNWtz?=
 =?utf-8?B?eEsyZGFoeUFpUUt6Q1FpU3hJN25QTHVPWER3akhVVExXT0hiZTJ4d3Ziay9p?=
 =?utf-8?B?YnFnVUYvUnNjbjJtMTk5aTd2WmZHaHY1T1ZEbWVIMDAwYW45VllYb3JOd1FX?=
 =?utf-8?B?dkVsS01jQlg2UGNZam42aWZRV2MxTmc3czVlYVF1VlNWOVY2QmVqd2d2eWIy?=
 =?utf-8?B?cVllRnh2bWZQMksyQ1JYL2hWWHBKQkFubkRCb1pNN0E2QVkyeThrTWJlbndN?=
 =?utf-8?B?VDhQYmFXZGJlaUR0TkRtV1JOMUNxUkhNK1lxSGY1Y25jK3pNWXV1MmVzRHNm?=
 =?utf-8?B?aGlEQTNUMFFCRWhSZjhJRHVnWkxURG5VQ3ZIWGk0dGM4cG1EL3FqRVBWZDhB?=
 =?utf-8?B?QjZsNGRBNGgzbExkYTE0VlpId21VcEJwWHNnYm5GUEc4endXMFN5ZUpDaUNk?=
 =?utf-8?B?MTJZaWl4bGNlTGFtQlk5dkt4cHB4eEUzSXAxSEc4MTJsOTFxWXZBbXVOR2Iv?=
 =?utf-8?B?REtwZXdha29IVlhIVk1iRGk5Sm1sb2NseFM4ckJiMkhBaXpMUkRGU1NmL3hT?=
 =?utf-8?B?VWFLdll3SklzUVZkRDUrZ0ZpNVg5MEp0SzluczMweitqd2FnakVLZ0JPbnEr?=
 =?utf-8?B?cEJXRW1USFFHczlsN3RpSEpoZ3NQZTlSUHlkazE1Ylo4TjcxUjMzVGN6UEVy?=
 =?utf-8?B?NkhlRTRWdkZWaDR6NlloUU1EYnJFUmdGZkhia0RuZ3I2K0R6U2pmUmUxcW1M?=
 =?utf-8?B?aVdGZS9VTUlNK2FEc2xZOVVadk1ya2JQQmxVM3ZlOEFPZi95b1c2WVFQcSt6?=
 =?utf-8?B?TEVZT1ZIc3Ezb29ZT3RwVzF3VGZnYXJJM3RHSTN5dWNPV0cxUVdhb1psZklK?=
 =?utf-8?B?ZjQxcUFxYW9oTHU3cUhtbGFLbENCc0dTcEdWdUVLcTcyTXBrVTMxZ0dRUys3?=
 =?utf-8?B?eVVHcExNRWE5OVRMbzk1NHVDcmRUSWxYeHcrN2hURHhjdDZwRnc5L2dueTQ5?=
 =?utf-8?B?Ykl4YjNjYnpkVk9tbnlZY3R4anlYeEp1eG9xMktyeGMyanpweGVpUXA1L3BY?=
 =?utf-8?B?djIySFBuZExwSFZFYmt4aGFKVXJkMmc2ZnpOb3NQWk83WWhEckVadjlqZGdJ?=
 =?utf-8?B?Zm1NWDVEcGFjVkJaMUtKbDF6L3lmelZnV2Rpemk0Z1lpV21WRXM5dkZscThR?=
 =?utf-8?B?bTR2SHJ6dW9JRHV1R3BJVkVXbjZXTURBYldRcVhwTzBjSVQzbTFRWXRLMjZx?=
 =?utf-8?B?b0FpTE9MUXo5cmxxeTFqMi9oTVdxai9RRDJheWh6VXVuMnlrcDRxY2Yvb0h6?=
 =?utf-8?B?cmJiT2pRZ1lna1JLdkhuZVR3TFBURFhnQ1JKeVA0Q3ZWYXU0ZDh3blh3dXYv?=
 =?utf-8?B?VkppTHdXUTFkOEhrS05KSjlubTFrblRqU0dYSG5yWG5Ea1crTHJReUVqRTlp?=
 =?utf-8?B?TEw0aFg1Sk5XMTUrQSs4RHFIY2lxc3BzVUlxb3ZDY1kva3ZNVlUxelo0dDAx?=
 =?utf-8?B?SXRCVlRIR25UQUZMOUo4Qm13RmVuV0lnRWRUelFQQ0xXVG9MK2wzT2hkN1Bv?=
 =?utf-8?B?ZjdiNll3ZXdIbjJCbGZJOWkwVGRuTW5GT0tsT09qUlltY0JUVnlWRHRLeDBy?=
 =?utf-8?B?L21HakgvSERwcXBtNFRyR0xFVEJtRmY3cXlkbG5ZTE0rQ0lHd3ZYS3FiWjRF?=
 =?utf-8?B?UjJsWUN1ZWZOaGViMzhNdzBPcENOdCs5eW5BRlVmQ0VpcDFnb0M3cSsxUGsx?=
 =?utf-8?B?R3ZaYmcvK2RxelBKZ0FmUUVyQ01OY2VGc2piamV1MHNIbFFYSmcvaVVNbU9V?=
 =?utf-8?B?bXpwVHA3aFYyZTg4bFdQVExsUjlra3diNFMwRXhXOWVZY25pSE1wSjFHT0hN?=
 =?utf-8?B?dEJJL1FHK29uRXUzM1ZhVlNyb0s0TVpKVmY3VmFPczdOMk4zN1E5QWwxYWxF?=
 =?utf-8?B?YlBTWjg3YnhQalc1ZGtURENOc1UwYStBNkxlYXkrbGszVnRVTGloellOOFk2?=
 =?utf-8?B?M25LRkNXcDVScWo1REVHMlhGK0hGZk5yckp6a0xtRFNhTjg5Zkh6MlpmL2FX?=
 =?utf-8?B?SEMwZGlZRzJIbGE4NmpTeVZldjJvTkNzUFNCTGxHUG8rOHkwRjhtNXBrUTc2?=
 =?utf-8?B?dFlWNHByMG1xOG92bWtFMXpDaURVSUJaV0YxUzI2TnJyNnRBU3FuM0ZnZ0hQ?=
 =?utf-8?B?dm1WWUlzTUVDU2VSZzFkODhCTjZ0Qzh6RVVueFI5b3A3VzJQMjM0T2l3bGRW?=
 =?utf-8?B?eloyeVBQT0pyQ2xrRHpoRkVGMDZNTFJGRE16aGJLTjRkV3FDOE9pdz09?=
Content-Type: multipart/alternative;
 boundary="_000_7ce43f76b51fb5f4d267cf95b935405fcd54fa8bcamelnvidiacom_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c665397a-3d78-41d3-155b-08de838a9e54
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 18:34:11.7179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SiOJdBxducBB5CL6nTnk88BTLo+fIW1YHkMCjYAVViRrWArwMasI9BvrxAywLbri61dSgetkZnnCpqkNoiNwQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671
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

--_000_7ce43f76b51fb5f4d267cf95b935405fcd54fa8bcamelnvidiacom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gTW9uLCAyMDI2LTAzLTE2IGF0IDIxOjA5ICswMzAwLCBTREwgd3JvdGU6DQpUaGUgaXNzdWUg
d2FzIGRpc2NvdmVyZWQgdGhyb3VnaCBzdGF0aWMgYW5hbHlzaXMgYWZ0ZXIgcmV2aWV3aW5nIGNo
YW5nZXMgaW50cm9kdWNlZA0KYnkgY29tbWl0IDc3M2ViMDRkMTRhMSAoImRybS9ub3V2ZWF1L2Rp
c3A6IGV4cG9zZSBjb25uIGV2ZW50IGNsYXNzIikuDQoNClBsZWFzZSB1cGRhdGUgdGhlIHBhdGNo
IGRlc2NyaXB0aW9uIHdpdGggdGhpcyBpbmZvLg0K

--_000_7ce43f76b51fb5f4d267cf95b935405fcd54fa8bcamelnvidiacom_
Content-Type: text/html; charset="utf-8"
Content-ID: <D74CE3966CFE7D4782B45199BA0B59ED@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZT5wcmUsY29kZSxhZGRyZXNzIHsNCiAg
bWFyZ2luOiAwcHg7DQp9DQpoMSxoMixoMyxoNCxoNSxoNiB7DQogIG1hcmdpbi10b3A6IDAuMmVt
Ow0KICBtYXJnaW4tYm90dG9tOiAwLjJlbTsNCn0NCm9sLHVsIHsNCiAgbWFyZ2luLXRvcDogMGVt
Ow0KICBtYXJnaW4tYm90dG9tOiAwZW07DQp9DQpibG9ja3F1b3RlIHsNCiAgbWFyZ2luLXRvcDog
MGVtOw0KICBtYXJnaW4tYm90dG9tOiAwZW07DQp9DQo8L3N0eWxlPg0KPC9oZWFkPg0KPGJvZHk+
DQo8ZGl2Pk9uIE1vbiwgMjAyNi0wMy0xNiBhdCAyMTowOSArMDMwMCwgU0RMIHdyb3RlOjwvZGl2
Pg0KPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4OyBib3Jk
ZXItbGVmdDoycHggIzcyOWZjZiBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4NCjxkaXY+VGhlIGlz
c3VlIHdhcyBkaXNjb3ZlcmVkIHRocm91Z2ggc3RhdGljIGFuYWx5c2lzIGFmdGVyIHJldmlld2lu
ZyBjaGFuZ2VzIGludHJvZHVjZWQ8YnI+DQpieSBjb21taXQgNzczZWIwNGQxNGExICgmcXVvdDtk
cm0vbm91dmVhdS9kaXNwOiBleHBvc2UgY29ubiBldmVudCBjbGFzcyZxdW90OykuPC9kaXY+DQo8
L2Jsb2NrcXVvdGU+DQo8ZGl2Pjxicj4NCjwvZGl2Pg0KPGRpdj5QbGVhc2UgdXBkYXRlIHRoZSBw
YXRjaCBkZXNjcmlwdGlvbiB3aXRoIHRoaXMgaW5mby48L2Rpdj4NCjxkaXY+PHNwYW4+PC9zcGFu
PjwvZGl2Pg0KPC9ib2R5Pg0KPC9odG1sPg0K

--_000_7ce43f76b51fb5f4d267cf95b935405fcd54fa8bcamelnvidiacom_--
