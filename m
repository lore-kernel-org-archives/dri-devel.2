Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7328E606A330
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 02:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=W9LEPq+3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33D2210ED2E;
	Sat, 14 Nov 2026 02:26:44 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA73610ED10
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 02:26:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akZ76W+LUsr68+WBp9VYvGz43mOWZvrr/CrPAVbhq62XRAwfY6F8N2191i0Gq0h5YZqa01ra6Y1VgCi2UDtqGstpxS+Wb5wRlL+Qyzv+FEFkhRX+5Y8JrXTRI8kV5sOwj5YA3Y9JsSYl4gP433y3aefRGSUqkVwxut48nDhMC/6iddzjKPI0/BpIXZTMPoplhqyeybsPbhDZNum8d04AL6NXPXiVifzbIxS2xbTES6S+/kWE8toIxNSefAxkL13A9/YzL0JVx3JM8XCG9p+9HZNZuOe7EbD2HkWeM7t6RjttHOwKH2Gn1T+WDdyolrxlUEXEprmKp7t7t9jUqLn5dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNZeRT71iFUrQNRYw7RA9g1rBf8kCg0KPPo2dB0Kqy0=;
 b=u2PK3mzQJQWR9y7G/RMJ7xt2ANYfWdnawTWBeVlWKeEMooHnE/oocvX20rInuR9/4pP+qIzLvphJBIid0qZxBMytSB/DEqnSSTE8E+AnmZ2hE8g1yYgKjDot0Qwf9Fb/Zhw6k49INlmaG3Ek3/fKFl7gouiHwkBY28r44gO4b7dcE/Mm5YW0JD79dtF4uwU84pDYDXc5f2MrpkpEhAXvPnUWbTwyH9OOtVCI5Ym5IqvLD5oM0W8mU7cmZfGst58nfFnZYbF3vGX/QvSVBl9sh7+QvND/HRz7t4D6lsX/bx2Ygb8yT7mX9N4vJAJ8kBbMWZewadwGaH1MPTTcPGHScw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNZeRT71iFUrQNRYw7RA9g1rBf8kCg0KPPo2dB0Kqy0=;
 b=W9LEPq+3XX1vzajUPtaGGfj4uvfapn5aQdZQsiCnVn7/tAXnwEmmo5FIzTph+Z1LbPD/C1dSYJprrIik4m8pdrxeE49n3V2N/6z+jK3JvT6oK44zT801LzWzrQDkeyOrevK8kLc1OOAZBoD/03aqTJK0HEQGLNdaLBGLpa9CUNYzC62xfRzz5EmLTV+d6XBLaDc0jBaXBODBdM2QrWqvnHQ/jc11Rjm0pX+o48RVBVbDBHZVZujJlaAauUm9FRFIo4yoZuH7kjy0TGutYKGd+IZ7gw8IK4SaxLvXWSDtXocRbzM4XQ3gZOxS0ApvPyGAo8/ulS6ljAgKXQ1PzWghjA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sat, 14 Nov
 2026 02:25:33 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Sat, 14 Nov 2026
 02:25:33 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Nov 2026 11:25:30 +0900
Message-Id: <DMUKT0NIC5YX.294W9XAS31304@nvidia.com>
To: "Vladislav Zaharov" <vladazaharova2018@gmail.com>
Cc: <dakr@kernel.org>, <jhubbard@nvidia.com>, <aliceryhl@google.com>,
 <ttabi@nvidia.com>, <gary@garyguo.net>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7 2/4] gpu: nova-core: gsp: move the log buffers into
 their own file
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20261113075317.934264-1-vladazaharova2018@gmail.com>
 <20261113075317.934264-3-vladazaharova2018@gmail.com>
In-Reply-To: <20261113075317.934264-3-vladazaharova2018@gmail.com>
X-ClientProxiedBy: TYCP286CA0034.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::11) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM6PR12MB4436:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf41d7d-b3fd-4366-c31d-08df41f68f3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|23010399003|1800799024|22082099003|261009223027099003|18002099003|4143699003|11063799006|56012099006|10067099003|261102123227099003|261021123027099003|261028144727099003|261026140227099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: aOyotowmbW4oCqJfxEvGZrkAxRF6T9GDltuelI5GV6WTyrc1PL5a+TvKLdZB5k9Yqotd4UVCmO9YgqIeKrnDDdMFbJrj5yw8FR3JMS4JQ37fO31pt/8W7bWE5+zRk8j3lzVy3kU3nX+TY3uNuXjRTtg3G8sxdOnlH8UbYFfeZVX1da0wacA05r2z6O7qqogKc9CRe/dA5UTTsGUosQ16e5Ada4+ni+w9J/YbOZLqWkfaXUpa6/iUJ1oYhBQxprpNrzgpnt7G28L1fO2Gvar235pPHqLESp6+o9JCU76Uei8BPl1eeXxOfNd1iCw0ZXt1ZdTDUckDxllKfD3Qw9FjKgP1AX/+ab70dRhUMNRkbxIWnXtbAHl0pTQOhpJ4kTHzru1p9SNxKJ4otj77rAp4xGFPoWaKm0OG5x2B4HZLCWwjG34ZFuA/uKezFabMpPBdmt1zuhLUnnWzBQZboEXrpWTLrcsy6h+9TWdmZTv0tBjZFtoGxZQZU86L8N1+exunb8+FbPGhWSZNYJqDetc6IktaFoVQ+3Pot4oGpH5m7XCOWtg5/AyLIEyLu3aCCjs923mPDqmnFcmUQ7d2gXgezcq5re/0W7QAl4TTb4IMigFEUOau3UA/VLDrr8EeM4Se9pzy/R5RWbiP3TY+/Wet72Eqg+Vf6GqzVuTaz1XB4eQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(23010399003)(1800799024)(22082099003)(261009223027099003)(18002099003)(4143699003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261021123027099003)(261028144727099003)(261026140227099003)(261022105027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3puNnN5MEVDZldrSWFHY3JJYkpYanBzRmt6RWFCL2J4ZkxpbGM1QjhiRHFa?=
 =?utf-8?B?bTMrd3YrOWpSNVhxRVJiTVVneit5Q0pSSGRLR3BLWkhFQXlRNWVPL01qYk9n?=
 =?utf-8?B?RG9aWmVMQmRvd044REtvMW1ieWpGN2MwT1RsTlRJL2E5WHF1cXJqVnpxQlY3?=
 =?utf-8?B?ekh1RWVmSjhqOTZmcUliY1h6WFNHS2JHeVZoSzB3NFlUdUo3Nkw0QWlrMkN1?=
 =?utf-8?B?bGpRL3REZ0U0VkQwZEk1YWRGOGV0bHF4emc4ZzV2ZlBYY3ZvL1QxWkVvRDhz?=
 =?utf-8?B?K25hZ3pVU1VxSTg4RzZlYk14c1NYSm1ycHZmVklMRDd0cGx6THlvWDlQTngy?=
 =?utf-8?B?OVJ2SXNYbzFSdENROFZZU0N5VC9GWVJvZTF2TUd6SkZ2blpPc2I0Z0RyaU1z?=
 =?utf-8?B?RmY1enZLcmpKejNFOWFXQzJ3UXB6MjhDcUw1NWNmN29VdlNFa2d0Z0xjYWo1?=
 =?utf-8?B?NEdrTk9NcU9iUlpDV2J6ZjB6NEYyeWp6dEVrdEVSdVgvbElLYml5ZEFXUVd0?=
 =?utf-8?B?bWRUMDJmMzZjNkZIKzcxVXNBSWFKazRNTzNwTzJTQWt2UW1CQ3AvcHJWbndZ?=
 =?utf-8?B?MXUvUktmS2ttOFhYdEFITmx5K2pUVEV2ZjNIWFp4MUJ1ZDZKZ1YyRSsrNjVh?=
 =?utf-8?B?ZE5VSmo0QnBncnF3RXBHSlMxLzhDaVNFSHVxTjBNUzRxYmo1TmlJOVF1UlRG?=
 =?utf-8?B?WHlHcDUwSGJrZmQvRWd4bHc0Tm5Cd0E0angxV2tYdXYwZ29Qb0YrZWozWlM4?=
 =?utf-8?B?MUZNZFFtaUVpdEp0WFBXbzVhbFoxaEc3VEZxRjdwczZwaGR4dXJRaEZKaVBo?=
 =?utf-8?B?VnZzMEk1YVoxTWErdERJVHJhR3A3NlZDVC93V2pCeEFkMzhsV2tOTkFEaG51?=
 =?utf-8?B?VlVncHRlVXhqeUtuc3lMeksxV1o1Z3NkZ2lrYUlrSkVmWGQ4cjBMZUhqVXRz?=
 =?utf-8?B?TlNvNTNVTFBaaGhpaG1TMkxwSWZaUiswcWZzb0dpRHdnT0h2VSt4bHZBRE9Z?=
 =?utf-8?B?a1lBTkQ0NVhGKzhGeG9TYWFiQlhNeG9OL2NNREJBY2FsUnhrbHZnT05QZzZW?=
 =?utf-8?B?ckRMRXVmbDVaYzN6SEhJRGRHUmxsR0FoQ0dDQnZlZTIrOHVKekphOEoxOUNz?=
 =?utf-8?B?VTIrdWZac2o0QmhqVVhGVE5ET3kzVVZ5eVgzTzY5T3pVUVoyMFNJRklGa3R4?=
 =?utf-8?B?ZHNmVXJuZVdOd1JqQWlGZHRWQVQ3NFcvVm1nWGtEaEMvUUd6SHBlNGx5aGlq?=
 =?utf-8?B?dy96MnNNbm5nODh4SlYvUlVldmtlR1RMVHdGcytMdkw4L2UzZU84eXExNVMx?=
 =?utf-8?B?MFFGaVlxdnorRGF2Vm1GZG5LQWtLNlFxVjkxTlhLcTJyMGhNdW50OWJSb01i?=
 =?utf-8?B?K1ZyTXpVaFYyYjhJaThhN3VYZFJsMVRaVVZXOG5RRFNYTWVqSVhudjZrWEZy?=
 =?utf-8?B?LzhFcGluRGRLOFFRMWJPSGdXZUJINm1rWGJ0MzlIMFNMODlscVE4UWh5VnZi?=
 =?utf-8?B?R3pSWE5yTzBYRHNjdEtTM1p6SWhjWmxCOE5PR1pmUDVpY29XZ3QrdnkyNWx3?=
 =?utf-8?B?K2gya25lYUhJSlpJR1dUTmdzWVhFckc0TktTZHdydlV5dVhoYzRUT2hneFEy?=
 =?utf-8?B?R21QUnA2djM5b1BqOFlZK1A1cGdQdzhzaWxaR0JPMHlDUlpZU1dHa2VlY2tL?=
 =?utf-8?B?ZER1czRLYVpuWkVOQWV3WldqMFVwWGxpOEJhZGtHaGRZbi9SMzA0OEZ1TlBm?=
 =?utf-8?B?bzRhMWQvUTJTZmN3aWRMWE4waDhpTU9XOGlqSjUrR3dBRFc5cHFlT1hPVUdk?=
 =?utf-8?B?T3QyS3JSb2syTEZhT010ZkFUSGFJNXpNZ1dCN3pSaENlTFRxazR2eXNsUzdi?=
 =?utf-8?B?SUJkT01IdEZxK0tnZ29na05NNkEydC9rSXZMbFl1eUJMVHZ5TWxkYnk3Nzl1?=
 =?utf-8?B?VWNoQkhnVGtTSjdIT3U5QUJybjE0elhwY29MZFVSTE5TbWxwWUtPOGxTRFF6?=
 =?utf-8?B?TlpITzdDdUZXOXZlcG04NWhXTFlESFFDaVJCV3NsYXFqVHBxWmpIZXhxVTFF?=
 =?utf-8?B?MGw1MlN1cHNSeHZFWVBWd2dPZjIvZFRiQkF5Rm5JaXhBRnhEd0lQL0JmM01w?=
 =?utf-8?B?TXhUZWpLV2xoWlgxbTV0eGJiOTlOYmt6aVhoZEZzcWRFdjhPOVFCYXZRNEsy?=
 =?utf-8?B?YjRoaVA1ajlVeDJ1MUpabC9ldGRIR0tCZ3A0OEJqRnNFaEk1WE01T3creTB6?=
 =?utf-8?B?dVdSeGRGL0hmMmNiRnpmM292bnJWbWlMaTViT1RPVitVRDVmSU1WaVJhSmZM?=
 =?utf-8?B?SGhFZDJXNzRMZVIwMkEvYWYxSENpRzZLNTZmUGVyZkpFSE1ZRGpjRkFJazBQ?=
 =?utf-8?Q?c4zXmJQefXuHG2VXQZJchEjQHjhbkhPQt1PaCXXYfj0/C?=
X-MS-Exchange-AntiSpam-MessageData-1: HTPc16q1KU/Hjw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf41d7d-b3fd-4366-c31d-08df41f68f3e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 02:25:33.2840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/gEwsyy7b0Aoky+bBAuJTZyKKj4koj2HzwrP24kpBpEDXIIo9YrW6aJeCsgDhly3S33qvW/N/xiuj+9syTuNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Nov 13, 2026 at 4:53 PM JST, Vladislav Zaharov wrote:
> Move the GSP-RM log buffer code from gsp.rs into gsp/logbuffer.rs, ahead
> of extending it. No functional change.
>
> Signed-off-by: Vladislav Zaharov <vladazaharova2018@gmail.com>
> ---
>  drivers/gpu/nova-core/gsp.rs           | 59 +++--------------------
>  drivers/gpu/nova-core/gsp/logbuffer.rs | 65 ++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 52 deletions(-)
>  create mode 100644 drivers/gpu/nova-core/gsp/logbuffer.rs

Thanks, the git `colorMoved` option makes the move obvious, and the next
patch becomes much easier to review.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
