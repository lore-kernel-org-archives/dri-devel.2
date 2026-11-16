Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E15E606A331
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sr2mHKmA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC66B10E97E;
	Mon, 16 Nov 2026 13:57:40 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010071.outbound.protection.outlook.com [52.101.56.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BDAA10E9F7
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:57:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1u+c4OaRk4YG8LM1jd7WlymmQhsGSF0h4XIRZuA3dfilgHofcW5S3oId8/HzhNOkvCdqcfA/TfBX+Hhcq3IsVYIT6TxW+sFeGoJ53PBizjv89TumX6amRA5iIB6qthqsDLmvihd/0o0xhUcESj4qTGLFBpLKNx8hcRyOKPJ02k5Tl6BSfdozzK+82P26ssmzcgexzzeIPezftyxHvzYI0R12dZgigyP3PMFeqNlMpiK7qtWZ/JzDpjrk3mBoYkf2NsACr2RzCdtyzak1QU0Fu0XjjGQ+EN3rpIkCGYRxRvii2Q1x1vFDfDg/o9lMho0t6b9ffqIxyB/G0r4n5IFEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkp8vFu/vOfIGXcOsL7K+kfY/ai4JGh2nOn6IBVxcjQ=;
 b=aH7ERz18XKqdtYTIAtSsXi0ccF/XLRMgY0EF56XJgVGDD7EmZDs4b7vcL7Yc2A28gt0NdHfzp0E6/CWJBmLUGZHWm1UX89iTq3rIoNka97LkSHDpOHGj16zqgKz2geiN88w/TE9Fq3X70MnaW2TrVgr9Zrbdd27YHP47gtQwfrpILnn8pL2BZmZwr3GMjkO75DvsKHG0J1pdwB/B1aO8XuMNuz1wav2YOqIQqz5kVB4CS8RPnUPnT1y7dHt58yI8RRWDst80Li/LB/bhtxHXXXd6IWYx9RxtuaPC900k2C0gaOgA0f+Wm1jfT7JC4i8BjXnqdZ9m9nE+Mf2lWUi9zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkp8vFu/vOfIGXcOsL7K+kfY/ai4JGh2nOn6IBVxcjQ=;
 b=sr2mHKmAuUAk6TLFCoidP/ROoANs6vAqTQK57Lj3Pz7fJbTohAlf5QFDMqVlOxxa/pGckk3wt+no70zmjd4wOhXnfMxafS7jzWEpOtVFC12X2Rqi38jrWE8Dln99f/G2wmIEFFpmAmKa+LLlqtGHuDKqupIOmx7ihIVoeByOcOBBdsI6sprVjFD+peV50KZdai/mlh7Txf6RSGQ1H+qOEoQabaln+8kxynoRSpwHeiK55RnqX2W+xntpdETwEKVZkRL7cLRO+Ajp1yy8fBH4A8dawfQ5WDfp8Oli/Xdu199sU2pX2w83cCnSZMtzPn81uAIDBCO5TLwlWxhab+RWVw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by IA0PR12MB7649.namprd12.prod.outlook.com (2603:10b6:208:437::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 13:57:23 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0615.012; Mon, 16 Nov 2026
 13:57:23 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 22:57:14 +0900
Message-Id: <DMWORQGE56HJ.1EHZVZ1M4NVTW@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: <aliceryhl@google.com>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <a.hindborg@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <work@onurozkan.dev>,
 <driver-core@lists.linux.dev>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 2/2] gpu: nova-core: remove unnecessary firmware pin-init
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20261114234324.82387-1-dakr@kernel.org>
 <20261114234324.82387-2-dakr@kernel.org>
 <DMWC44MU9W7N.3TBNH0HCKK065@nvidia.com>
 <DMWMWJV23VO4.1V6D60QKD5KT5@kernel.org>
In-Reply-To: <DMWMWJV23VO4.1V6D60QKD5KT5@kernel.org>
X-ClientProxiedBy: TY4P286CA0119.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::16) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|IA0PR12MB7649:EE_
X-MS-Office365-Filtering-Correlation-Id: 83514b28-a918-4aa4-5c29-08df43e989b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|10070799003|1800799024|376014|7416014|10067099003|56012099006|11063799006|4143699003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AfxDrDJLMdvB5St9wS0VOzQBZ/n2WkTYucGHABb03pD1UsR1zM9t+PES550gUfL8kfi7RndZs8UlfL7jsWKAq1mNErWVPm5DcCkv7V7LYnsIk80FmgjbKdbGemhKjr7lIGPEzIJp8TlNsGiR4F7ATcTVtcMVGs8gtVVsJy8eVZWkAJ2KNeW/VvlwCl2A95NpGZD+hSRnQ1PMDIg6fi5RM2IS1Mfm1IAVSTyZV1Z0Coh85UXmdRATehtCfaSs907hU99rw8hOXo8AlbM5ah7ygLscuiOP0oA5hmgHQl5Oa7NQtzId4/XvMH6MCJGKm47wRgh3HNHNO3C5GgiLNvbrnB1OvbYj3QDz4v4zQ1JIqNBF62Lk9OYZrFOI4RSxlVJ9zNd/pEFgoytdYSudjpe/uscGcAGRo0rmePXtwi+AFCJ3tCLTg561U1NoP4TGAVB1+hB7O/TKk/y2Zdq4vR4/vxsgq59lrVEh3ritGaRtRgOTD+hUf+osdpC8BYeAfOdsof0HYDkn9w1D2Wjbcr9fdqLUOimeVX/r/chaidXz0KaYLGEEaZ+0unySHpIIdyNuOQfjlc+DJRdEoZEr16IW3SSfyeXIEYRvkaj6veI2wOCHhJ1dnNIAc41xBotkpoP0wOE5nObXbOG/5jZbIjoFp4/u53c+jqSPAUkCrUPbsb0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(10070799003)(1800799024)(376014)(7416014)(10067099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U25sVnV5QnB6YXNYcUZDSXNxaERsdXliaDFXdktEZ3FWaXdiVnlpWG91OURt?=
 =?utf-8?B?MW5zcmdlUysza2FwK0kyaldoaXRoMVEzdzU5QkZZUW5kTG5XWWZjYnhrR3hH?=
 =?utf-8?B?TTFqS1hrUmNrQWJZQTJrejE4VDNHU0duZTFXRVo5SUxJWWkyTU9JY0t6bkxs?=
 =?utf-8?B?akRQNkxFQXpsaDFNMWV3REF2eE9MbFFGTmUzdUgzUVpRWGhJamh4T2FLSVVI?=
 =?utf-8?B?Tkd4YjhGZmFXU1VNUE13d0tXb1RGeVplSENjenF4djRQdkVlcndTU29GSmhV?=
 =?utf-8?B?WHVRWDkyLzJuY2VXTEhIQVhwTElYL2M4cXExTVloaXYxcHYvNUdsSFpsb1Yx?=
 =?utf-8?B?ZzBkVDY1RmRDeUdWNWZRYVdnbS9mcFo3VnoxVDRrc3NrUmlvb3pTMFYyaEda?=
 =?utf-8?B?NGwvSnc0Q1FtMXJIc2drM09nUU1FcS81L2dNM2NxRGQ1LzMrM0Z2T2pYalc1?=
 =?utf-8?B?R1VJT3ZDWlpLaEJlU0ZlNVFNY1FEUHFjdWJkZHRER3pYZHNhcVpsYUpocmhP?=
 =?utf-8?B?QkF6ZUI3UzMwK1NEa213TnRnd3pKYndpbVZ6U29jdUx1TEovK2RvV05BMytx?=
 =?utf-8?B?bHRYdVVjOXlBbXRrdSt3bDU1cEpNcXgwZE9mWllPNzIxZndOVStlTVM3T3hF?=
 =?utf-8?B?bXdaR3cvYnBFc2ZaMTNXZUxySHlKY0tBYjkyL1RvTFF1QmQrT2txQWxvUkVB?=
 =?utf-8?B?LzNZeXdNZlhZN2xheUZEYXFiNWlDdlU1a3N0K3B0b05TaExTYm13dUoyUGph?=
 =?utf-8?B?Tm8xZ0daU2tQOWFRNGVYVGtLMmw0VlNiczU0TG5TMUVxS3ZndDdUSE0yV2JQ?=
 =?utf-8?B?cS83SlNGeW5nL1RyUmVjbVQ3WU9MbHptUUxLemhoUXlzZFkyemRzckxra2Z5?=
 =?utf-8?B?NExqTXUyb3gvcDNhTml1RUgyK3Y0WUNEeFNjNzdTaUNFaWhwVldkZS9DbUZC?=
 =?utf-8?B?MVdoNWRMa1ZsTUhJQTJKN3ZSdkJpRFh0RXVqaG51ZjVFTDY3YzdLanU4eUFW?=
 =?utf-8?B?YmJiV1krc1dVMmFkQlhYSmtqcUhnQy81UFpGbk9ZQmtJWnAvMDdIb2Zxa2dZ?=
 =?utf-8?B?Wjd2dG5XTXVicnZTbmw4UUZHclVVM09IVzNmbjBxeG5oeFJ3UzRHc2dDRUlQ?=
 =?utf-8?B?Y1BGTGMyRnVJdmV5NGx2MGZXcnFRSWI2bGt0amFhMDZoNU9heWhHVTN4MEtD?=
 =?utf-8?B?TWhJeVFOZWF0cnYxejdjYTVNODQ5Vk5JMVIrbWdsL2VjNllEVGlhZ3BPRks4?=
 =?utf-8?B?SG5xMW1aSUtaOHZES1EwN3EzYTg2RVFuNlhVbzBrUTA1bldWYWJCblhHekpM?=
 =?utf-8?B?Rk43WUUrTFdyVXFxeXdLbW1ObUVad3cybkthY29LNlc2cVQwS2Y4VjVsdUJj?=
 =?utf-8?B?Q3lmWmlOWHF5eUluVEsvR1lKakswUDl5b2lqQmF3b3dWcXdKbGVpMk9Wcm9y?=
 =?utf-8?B?NlFhVXRFVHh4dkpIMDE0TStJaHVCS2crZlB3VlJPQThhWXFRR0RSaXE5UDBU?=
 =?utf-8?B?bSt6ZVJZTW4zVEMvcjhpWmU4WXpLSFZTekpaMzhMeVBzaTBwdDdmZ1hkeU92?=
 =?utf-8?B?eDBhbElsQ0hGb2gzYnRpR09jNlNnbEs4RU9LbkVYM3c4cGxUMzB2RjdTNDB4?=
 =?utf-8?B?N1l6L0hyQUdzelRJQnFueDNwMGo3emdTQnVvRitnY1N5N2phenJnQkttdFBT?=
 =?utf-8?B?d2xKUGRLclZ1cEd1VTFQWnc1dTFvZmtkaUpWTHg5M0lRaGRJTW9uQ2NVNWJy?=
 =?utf-8?B?UFlUTGx2ZDJyU2hGUDdRWVJ3UnJ2OC8zOGVwS1ZMRGRmbWYzTS9TeU1IbjRF?=
 =?utf-8?B?MC9zN2lWZFlBbzgwT290QmpvOGxTU2FJaThXTldPZjhpeC9LZHB4c04vVklL?=
 =?utf-8?B?ODZFSU9Cd2tPclB2U2FjY0RiWkZ1TS9SWnJUMnlWbFpOcVp0UXRGL0IyUktO?=
 =?utf-8?B?dFVyUCtMdWxpZHU0RkM3RFNRbzA4cmRYQnpaZi9IWGY0c29hbHBNb1h4WmMr?=
 =?utf-8?B?M3lNSWRQbFF3SUdhYjlvTG9lelYvQ29iVGovOG5RLzZnMVg1Y2xXZitqdW5H?=
 =?utf-8?B?UjZIQXdLRnRTWFdLc2dlS3Vsb1dRT1UrTFlzSzhJQjJpSE5KenRxVGVlM2hV?=
 =?utf-8?B?bDk1dGJGaW1hZHhHTkxhY1dJRUluT0hzRnQxbXhvRlF1ajVoUFJ3UXQrUmRr?=
 =?utf-8?B?eWxnd015VTNVVjFwckU5c1FyK3JjeUh4NWhTNWhOMkVUZDljby9wbk56Vm14?=
 =?utf-8?B?c3pRenR4ZXk4YlAxMWJTdldEWkorYzU0TTd5aG8rdGJ4WHFyTTNzRTVDRDFq?=
 =?utf-8?B?VkNkVVEzMHpYSXJBV01tZTlST1hkcElNSER5RHdSQXorcnFyNUROM292VStD?=
 =?utf-8?Q?0/pzT4grg17Zr+rFmWSTdueo+USOpOHUXBy/uLrTzHmLD?=
X-MS-Exchange-AntiSpam-MessageData-1: pJidfZuqHvFdwQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83514b28-a918-4aa4-5c29-08df43e989b8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:57:22.9164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7IA2Ugur6ohFe834QUk+7HzV+vEG4F0B2JP3b9PuWifTagI27J5JVYBk4D0gyvdjgV1g+fI6tPF+P8Lhfp5kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7649
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 16, 2026 at 9:29 PM JST, Danilo Krummrich wrote:
> On Mon Nov 16, 2026 at 5:02 AM CET, Alexandre Courbot wrote:
>>> +    pub(crate) fn new(dev: &'a device::Device<device::Bound>, chipset:=
 Chipset) -> Result<Self> {
>>
>> `GspFirmware` is 312 bytes, that's not enormous but that's also not
>> small... Shall we keep returning an `impl Pininit`?
>
> I considered that, but it's only ever constructed in Gsp::boot() and does=
 not
> outlive boot(), so I think it should be fine.

Sgtm.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
