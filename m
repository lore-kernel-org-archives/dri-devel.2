Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5EAF53D71
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 16:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E321710E403;
	Mon, 16 Mar 2026 16:28:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="aLSNjRUs";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013063.outbound.protection.outlook.com
 [40.93.196.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 062C110E3AB;
 Mon, 16 Mar 2026 16:28:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2XdjKEuKUVnZrWnAzsXwnv1DMJ0EkctiTUgv0OVkjyuuvOs+VNkHgCiQ8DnzmpGLTSX+c38uty8WwDKd3383hgWNjxWS8TNdMmGea1bsaeeqGTBWW+xnpbwGhxSVCoGG9eXu5al00Sd0S40fIOYXluiQsvcKFhFlUqemxWkutU9SE/fuxy4JO4rCztwCmwDAaFNPyR73LKI2maD/mNq6f74+BqZve3IlmUa5dH77Jqs1YLZIY+PXqt+yHQSUrA/4amdFdYS6WHLLx15oWgJTN32BRdlFzIbvCa2TM0lw95KcOjwGT6g+UptyXwGhdGrCF8UT3+R1b7olErr0J8uNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVIh+wZrR23dyQ+uuLX8EtRUMNLOZnl/PktHeEX57EU=;
 b=JX3Uk1oIKxz5kBuwQtU/84X7YkmMDR8WDj7qMnMz0U0eqeHmwB6lxug/f5DZt65TBd7rW3cRmzjyWtvB3315ZR603BP88ZhWC5Z1kFb3jm/TjJn/TZgB71KPXRON147GrTOiEZ9wXPqZvRfdi+e3xrC6oMo62xEQ6F2X1J4kY7/DiXxfNoLzr/1Y0U/4ZCcDKx4IlS/fpMFAL53snToY38CsScwVDkYQiY79p9YWIkgfbTDD+H1DuO9yRDyZmFDOoUglUc6wpjbX1QIduacdmeiDFFukYXr/LaCMEJwDE3ow8ylF5Gkou6EFHYHmpYp5LwLeU+zTy7elgl4Voik65A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVIh+wZrR23dyQ+uuLX8EtRUMNLOZnl/PktHeEX57EU=;
 b=aLSNjRUsBschn9KAbY+uNmf7RwVRWQTPlfE3Pz/YrR9NLN/ZWxEpQyulMu5dAymNoCi8GcTK6t/w/xnC47VVQzcImwJoCU6LqhS0AoQbN7oZlzW492svhPXd+l8KIwYgaK7P0SDSecCSH9rLoSYo5Grdx3qE5ey3//BRO7/dCpsT9RbxBnma/b6FsbWBjrU2kUPw2v5UKrS3viQTEr78dQr9lDn1ouhhgmXSa3syu2osym28zqbnp2HzxMJ/a16Io/QwtgudVNYXM7ZaTuL7nFpSJtEarB25N4w10h0ADKGokhCSTeW5iAMu6U6qL+hEfCcvlgT4r2sY4t1EXPdwbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DS5PPF2FA070BDF.namprd12.prod.outlook.com (2603:10b6:f:fc00::649)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Mon, 16 Mar
 2026 16:28:34 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 16:28:34 +0000
Message-ID: <4e34e52f-9990-42b2-8c38-b817c984560c@nvidia.com>
Date: Mon, 16 Mar 2026 12:28:31 -0400
User-Agent: Mozilla Thunderbird
From: Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH v9 02/23] gpu: nova-core: Kconfig: Sort select statements
 alphabetically
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Koen Koning <koen.koning@linux.intel.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 Nikola Djukic <ndjukic@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 joel@joelfernandes.org, linux-doc@vger.kernel.org
References: <20260311004008.2208806-1-joelagnelf@nvidia.com>
 <20260311004008.2208806-3-joelagnelf@nvidia.com>
 <DH48HYK3BB3G.2JZ3N4JG2HD5X@nvidia.com>
Content-Language: en-US
In-Reply-To: <DH48HYK3BB3G.2JZ3N4JG2HD5X@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::16) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DS5PPF2FA070BDF:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f205925-7cff-46b9-3e1e-08de83791176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: gLWXjPA27sbiLRsTata2tUoI73P6UfwXneQ7jiJKPXMBywzGULmTxoMk7umpOxkPnrO0WNYXKlzBs2g30HjuRIABkEaIiygxeQtHzibqby6NHbiL7qLZ8BbopnRjn8mMRjM60EnyiIPI/X5E3xf7QFD3Woqay8b+N7bt+AqIPaogS9/HTtPIYd1aJIFZMDphu7WOF7JUUBuebY1Dc93FNQo+qmRzMLK+uwBqRMkdxHlmbwZBPtr3O97PADZMn0ZG4qJIF73O/S4toOBxjcmNlMeBGW6X66xjfTrCI0odhpUne3iQlEI2gbcq91sJ86GrlTSLqmclyve13K6EuBREGyZgfNKm8e+P8hnK8f7EG2/HVwMFreo04KXkBVtTDG+6HFio7LYa7VegaBxEK6uvdz/AhMOy7gKjdqkQY9TelyseT0GsuuXeBRloz8Xwk1qeNR0HCUnx6xfdtdz4T8eHfJedUbK6BMOXc3wIMFFm6FTtS6JZVeoZ4WHZBuGmIHpyQgu1i0yqFlbdP3m/woAOybq9p+t48nUv6h63gA5mvd8JXXDIrkPCvf+rt8sE8iMEcvQQFkAHvjUxDVg/RVpAEfv0T2xtapQZjTUctLnKNMQ89AUEKH8wVKIOShQ4654No+hOjkR2wuMM/u3/vcjVDshGa+1qPWDkTiH1/qggvZl/vqyDZoUY+PVRQv5zaeFZM2MnGOLBWyZv19i7sh3HVD08EH7DjFF1PRQamsyNWdM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXBrMEorK2lXZURUa3JKbitXeCtiVnMxZTgvOUFWbEV1NVNWSzJoNUlzZU9s?=
 =?utf-8?B?RDQ0MjBQVVlPait3Mjg4N21uZXdoWTMya2xHUmxJR1U5dmljMUYraUVMVEhz?=
 =?utf-8?B?MXp4d2c3N3JodlEyaVNrSXdRSjlhMktZQktibWkzODVKYXF1SW44SEhhVVZv?=
 =?utf-8?B?QzRiRm5CRVRIWUxzU2JyczNvajF6L2JaeEt2UGROcytzMGpHZDVYYi9UbUMr?=
 =?utf-8?B?UG84UGQvZi8rUlVxSW5saXZYOFZ5TXpJV2hsamoxaEswSUQxWFJEekJkYmwz?=
 =?utf-8?B?RkVQNUFuR3NBVkE0V256aXpwUFQxRzZSTG1PYk5HQlZWNUdFRDYxOTFUWlNP?=
 =?utf-8?B?OWlmL2NkSW1tRC9jZnRWckdXODhrbGJFU2s4UmlZdC9aWlRDN3VTOGY2UzVH?=
 =?utf-8?B?WVBJYi84WE1VcUM1dDJJTVhrN21wV2pmeExSZVhSWHB1SXZRWk9VMDlRMEcw?=
 =?utf-8?B?SUpUdTBod0wyZHhSQlBGblovSVZGUmd1S2R2QStvZkVaRXBpSFdmMnQ0TXhX?=
 =?utf-8?B?V0w1c1dhcVBSNHg1WGw4M1JJcFhFWjhGYlA0TnhOR002cUQzSEZoRk5nZTdj?=
 =?utf-8?B?cVJSMzQzOWQvbmpBdjA4U043SzUrMWFwRzE2STBTQVVMODVZbVJudnZOTXRo?=
 =?utf-8?B?TGlMWEFrSmNXUlZXT3h4cTVGbkp6ckw4blgwZ2c4bTgzMFprM3VlTldGWjZV?=
 =?utf-8?B?dVFiRE1WUGVmWG4reEVCMFZhbmIwL3lFaHVMZlE3Q2Jsb0o4WjNBMCtoQ2hj?=
 =?utf-8?B?dDMzQkVqNTBCRURKM0UweE1FazM5dmt2VEVlWVdla0U1eWh0NEJmMkN2d0Q4?=
 =?utf-8?B?UDc2N3ZnS3piN2Q4N2ZLYXlJY0NqZHlkOGdQUHJ1ZVh6VEY5eDVjZ2ZNNnZT?=
 =?utf-8?B?MTk4N0Y3S3NZM3VpTXN5ZHgzZ1ZRSk95LzlpUExlWGlJRG9qRmpEdFM5L1JV?=
 =?utf-8?B?UXgvWWJjODdZSml2aWROQnlWU2RabC8vUE9RNEhXc3h4YzF4U083VTYrb1JS?=
 =?utf-8?B?emJ6SHBMWnlBWGJKTWc3YUlhQU1uMlBvTWNtbTlKSVRJWVVHbk14eUpoRHNn?=
 =?utf-8?B?eFQzRE9WSkNNV0lQK1ZPQzJvNVUyRGJHbzVmWWkxenVEMkNGUnk5RVhlalRZ?=
 =?utf-8?B?TkxySDR1d3pKK0VGTGo3bTJKSTBPeDVWcldhOUVMN3RxMkxZTml1TXlQN1Fl?=
 =?utf-8?B?RWk0MEtzbGV5UzVDd1ZTK0VzRTdJbEpoQi83Mjk3MVFTTCtmUFdrZTBVZjZt?=
 =?utf-8?B?eHJFU3JlQmp5MHY1TUk3Tlkya01BTHB5bDB6alNOUVFBbm1pbnBOeTFQYzUr?=
 =?utf-8?B?ODJyNVRGWng2b1kwd3VPUU1uZlNjY0hWT0VMY3JXRHNUMWtjSnNvOFFJQkI4?=
 =?utf-8?B?bXNIUlJIVzV2N3Z1S2VHY1B3Sll1ajNoaldKa0NkWFJ0d2NMVmczYko4S2pB?=
 =?utf-8?B?anRqYnZONTNpREZUeWVDbW1VMm9ZYlB0SkdEckxFbUpobGJGTGdsWklIQ0RX?=
 =?utf-8?B?cVo1MFFXdTl5YXdKWjhpMElROHRrMjdBeXJoOHhrWDJrVWtaY0JiSko2aFVW?=
 =?utf-8?B?RlZyR2pMVGpoZHBPZVF3cVZFYWRGQ3J1YzV3VFp3Z2tNOFlGS2w3d1R6MXhF?=
 =?utf-8?B?N1BiYzExOFQxSkpDTGIvTzhSQ1NEdndLRFdjcFYvLzU5Q0ZKb0M4MU5TWDdr?=
 =?utf-8?B?d0JiU2l5M0tOd2pUbkVzYU1nTGsxTzM3L0RJUy9ZaWR3bWV5RHpHWnJjdkNO?=
 =?utf-8?B?V3ZkT2hPU0lWTlkrZDg1MkxNWUEwclZiUzJpZ2tMNXB5TXJ3SzU2QVlrejBy?=
 =?utf-8?B?aUdSSVZhVWthZ2h5d2hUTTBDSjFHNC83RnlPaFdEelIvT1hyb2JSUWVlY3BG?=
 =?utf-8?B?MHY2UDk0VWtvNHVwbjdjeDQ2M1NvSUd5RzZBMDk5UE9QVXIrV2lySXd6Uno2?=
 =?utf-8?B?by9YdFozU3FvMDhxem92ZU5qSjR5NXpyMmFiUFg4WktWa2szeEhIY1VQUkg5?=
 =?utf-8?B?RmpJT3NCTmZkZ3pvcHEwOHlxODQ0Ymd2dW43UTg2RmYySFlpd3ZEOXVkVUtP?=
 =?utf-8?B?eFpkbkJWcU9zRkFYRnIzYUR5bkZTTXNjQ0lGMS9raHNlTC9ONE9FaC9VUWY0?=
 =?utf-8?B?Y3FBL3Fod1RxZzZLWDdBQjM4QllmNjJqemdSZkk2MzJIUVFDUjdQZi9UWUNp?=
 =?utf-8?B?T2FuY3kvc1U3SW1hQ01NSzdiSFo0bnR3M0VBSGtJaldPYkN2R0REaForNGxV?=
 =?utf-8?B?VURmeFNPY0wzamV6VkNBVEQyM0lOU0ZkeHR6Tmx1eFkxWHh0Q2UvZGVFeGlS?=
 =?utf-8?B?cDkyaG9aQmpKVUljc0hmRFU5bVBIRENyekc4R2ZyYTBhOGRNL1ZXZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f205925-7cff-46b9-3e1e-08de83791176
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 16:28:34.2194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xOrmlHIMzDvQuMs+3py5ODYsCfTLLU0dhXgZ9iKL/RsaBFyPpbB9xuEgqw+z4ue7Xib3eZO8GLXlBZwRh4su0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF2FA070BDF
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

On Mon, 16 Mar 2026, Alexandre Courbot wrote:
> This one is already in drm-rust-next.

I'll rebase. thanks,

--
Joel Fernandes
