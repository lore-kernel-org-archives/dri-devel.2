Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9E3C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 04:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 997DA10E2D5;
	Wed,  1 Jul 2026 04:06:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ot/2yOlz";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7719810E2D5;
 Wed,  1 Jul 2026 04:06:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5DKKNxFRTNOH8tm9Ws36lw77HT8nSlaInb1UAhb75JOvJuPgpYOS2x7Q2nBAPM94dvRshzetIQs/GqLEyzxefq0DjDUChpRkGQscI14i0SmPxOzHxsDvq+2X0YjS4xLLFkpUE1CFaQXX4deqiXdUi/Pa7JxJPUFA3XRZHwBoix7t0aKxXm98j8/zt5lbb5v9/pWK8iiElSDpXGrtv8f1sk3oVALQRxa7zJ0zMV8S7ig8upTHoBSPuDNyssl2a6W4OXPvJmx/3UdFXDNqH2IR3YZCA07ILfss5Gobq1JnciTo9HaWaxJ6Am+leK0YprkpkIs6/EoAgpbS0Nr2yCmgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhyrWAIScaUY91yBQQJ+Q3eLgC22q92pTODiNy1lbFw=;
 b=qagM8b8bQM6DXH5z7uh/3ho1mxZAcGIEhHFXM448zAblstdwduiCiWOFPI7h8LtTN4isF2KDXl3tPpina7fwV36aU7P1QqVU1SyabpsYRxj2z3SCwkwsgE2lWs9pfROAMTQMaC5VC7rzESxlUscsSLXo4L18Ol643aRdXS/JTVWOA53H3rz4Ysp7qDsem3bXDpQSZTKJrPrN/NqucxRImoduBpxxQ4VFjI90/Rim8ipo3Ak5kubFwU5g/g6C3lrAqW2vSiKJ+SrHTJ+VjElLoA/RAZmITKT1186UOybE+LKuxfjq/EiIrjHBd6/FfCqEWaZVgTa4CDb7eNw7QuMPOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhyrWAIScaUY91yBQQJ+Q3eLgC22q92pTODiNy1lbFw=;
 b=ot/2yOlztxAchAiSU0yz2vBdA62/6J075lIW+kCwTVP8junyi8pZx8KxYWLYvCNx4sPsYqeOnQXJfdnCNC6dFjUFKIorQoqCbVIkhdJ6N7vX2CG7kxtUYw4S7P8nrPfj3ltbdqytwXpF8htV/GydoFt7J4ziFgLFHqDQMPe7antsl6Gm+IA+v3f4BTftC28dzQsyPo41TfXKUc98KMOdGSKw823Gw9Edz8LkBSHoLfykX4paXyT+RETyHQcSRKs2HYwdmfgauYLt8IfB68U7hWAFoXS1HxMbGI0URgGja3qpS5qKFTAvC32NZ2I5fpBRUHLenIG07QHYDgI8+PY3vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by LV3PR12MB9402.namprd12.prod.outlook.com (2603:10b6:408:213::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 04:06:32 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 04:06:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 13:06:28 +0900
Message-Id: <DJMXS8LOIDNZ.27FQMEEG3YBOV@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 05/13] gpu: nova-core: gsp: centralize missing unload
 bundle warnings
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
 <20260629-nova-bootcontext-v4-5-5539d8469590@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v4-5-5539d8469590@nvidia.com>
X-ClientProxiedBy: DS1PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:8:44f::14) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|LV3PR12MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: 603ccf07-509d-4b5f-98a5-08ded7262247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|10070799003|366016|921020|18002099003|22082099003|4143699003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: YSsz30djFCmJjOmoObeKU+41+bD0Uru0t9cgtbfTcoA5Ch4C8pIDvXAWPT8/zv4isxzsrDwPZ3EO6e59zVAIsbvTKrXGYMDh7RD8gd2sSi056UGeDYcAg3+Im49iSK3TEZHm9ucGrwzGnHaTdvfbjmzmmlg1MKPwhl1Zi0s0CwEQ+cAPF63ezjoNe6IBvR/bOO2bLzqD5vMuKSBokfBlzyZItJlBbOxW2qr3LchMxHU4LYCgU6IkEoEAm5mfRYZuTH74CP2MM47zxfkTlB9f5JWKWaDkdsAjwDXq2873wHKQ2AiQDIkb3AlCVOhQWJB4Tnsw44dc534zYBcCZkJsYRQAcZ3NZAeUAQ0StlPK9HU53t4wCMS8jrffM6/o3LqtZkTxhA9APr5amO/k9FdOmecS81AEsMb4mNhH5PXOhQhb6bVTxiq7xDTwJLqT6G13xGG8qKcU1fNKgItQYoYvO7peMX1PnJGPyVybNX/7FAIpMhihJTkMQSQjV8H3wiJaXhDN4ih+lRw+/6X1DcmC4mOcCQ5PqbsXIF9+mkqDB84TmXsf2/Ymf/cbMxXikrI5kpebPCIIf891XuVNgO+fwLyP+4bmDJbha0KuzKeHrY1XXadLjwZvcUoOqMguj8H4oix7lDG16UtAfGTx6tASzMKyUh/q2BZQSjnGMsbTC0el+DCIEQDracXP6DZLrpcm4o4Ju4QvhFH92UBowhw9pA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(10070799003)(366016)(921020)(18002099003)(22082099003)(4143699003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2N1UFRhZXB4Z3RqMENwZUgrTE1ZdmNnd3liaWd2d0s3RWhTallVa1QrY0t4?=
 =?utf-8?B?OEVVY3RoNXY5Sk9KSlFCMllOZXplSTFKd3o2QlpYR3FSWDJtaEwrYjFkVFc5?=
 =?utf-8?B?T1hxbDcwUjBtaTB6TW82bnJIdnloMDI5QjFVNDNRUmVVRjBZYy9zTWRNVTU1?=
 =?utf-8?B?Uy8rTlV5eXdJdGNtNlRvd3E5NlM0bFBNczRVUk85dHNxc1czOHpLMGFMNWhp?=
 =?utf-8?B?VzZCRlRGNmZhOGlITGUyaWx1VURUQTBCcHJHWVV2b2FEdmZxSkVSM0hQZ3Ns?=
 =?utf-8?B?OHNtVmZiQUl5bGNKeTNRbHVxVXU0YlZweUYrK0dqMytaQ29VZnpldDlmeVUv?=
 =?utf-8?B?eVJTdlkxVWEyNGdYR2NVb005b2pWM1hsenlKbllCWjAzTDgwYnBBbU91RWFu?=
 =?utf-8?B?aGdISTJxYkNpMitabUNveGhLSDg0N0dkSmFlZXhnNnkwZE5Sanp5QlZBTlNj?=
 =?utf-8?B?L0tQU1FNVFNKV0FSRGg1dGRHMlc4MjJCNzJsWjhBSmZ5V2xUNW40T3E4S2J2?=
 =?utf-8?B?emNXTGllMndCYXlmSGNiNXhsNlJTT1RkSGprZGhnaGlselFzUDNoUGU1T2RB?=
 =?utf-8?B?R2FmK0hxMWJuTzdDWXRnR1lOSFl3emYzU0VQNUd6M1ZkM3o3RSt3TU5DUlBC?=
 =?utf-8?B?dVdNOGhsaXNpblJHWUlReXp6SEp3bm5zaStyV242eDk2M1VINldOWFEzbk5R?=
 =?utf-8?B?WUxJTFRqNUUvRkFmY0JIUWJPREhzZk0rODZUUXF2a2lkbnB5TU0yOExLLzcz?=
 =?utf-8?B?Q0dLT3o2VklML0hDY0dnMk5hV3NQa1lDQmV1cGg5OURCSUhXUHBOa1JSY1hp?=
 =?utf-8?B?SXFudXRjbXl2SVN0bkNuemJrejEzeGEzOXc0cmFLSkxDMDB6WVN5dXkzWkVR?=
 =?utf-8?B?YmxGbmpUSTd3cmpMNlFIMGJDWHN6U0Z3Z2xobEN3bTRYUUh4bFcrNHpIWHZW?=
 =?utf-8?B?MCs5OFppUlRpV0tXRXVpbzAzTk5QOXdxTCtDMFlBc3dLL0FSOVBQWFNGSVFU?=
 =?utf-8?B?MVhrQ05aMVBRTjl0M0tCclE2NldMUHNIME5USFN1M0JMYWUyL3BTUjlDSm5h?=
 =?utf-8?B?V1FhZFREZXhDNldXZzgzWGxNYk9CZGprY2xSQ0NOVmR0bEhWK3cyOFBRTy9W?=
 =?utf-8?B?OEZIbUhpSEt1UTRRejc5Zmh3MkkvQUZsQ3RJU1VObHhENFh5Z1duMEtKeTlz?=
 =?utf-8?B?ZG8yYmdXbytrTk5CT2xXb2U1bkFVd0YwSWlRbG91QUNES3FZeTA3U3E0UDVN?=
 =?utf-8?B?MUkwUjYrNnEzUy8reERHc0Z5MnpBMk14TkYwejAzd2RPVHcraHZ2Y3UzeXZo?=
 =?utf-8?B?YlVMdVZFbWJRSm5Uc2tJL0lzbjNrd1NJMGpMUXkzM1NaK3o3YVFhTmVJdXUr?=
 =?utf-8?B?ZkZPM2R6aVlLaXVHY0VSY29leWxOQUQ3Y21Cb0tEdCtRdy81YlhSN0szbUlX?=
 =?utf-8?B?SmFtREozN09xbjliN0xmd3hSY0t2RDlIbkNHemN0SHhwc0dkVjNOa2RzQWt3?=
 =?utf-8?B?N3Q4QTl2RzUzYy9iN05sQ0FzV3drZG1Kdnh5TmRrUjB0MnR3YWxRVUd6bjNP?=
 =?utf-8?B?eWRYeVdWUk9PdEE3Q0gyVjZwKzJKd2hXR01SRjl3UG1YeDVlZTJlbDY3MmZS?=
 =?utf-8?B?QlpMRzNWdzl3ekVHazRwRFBnUEh6SEFjSXRRekJhaXJ4M05uSHlFNXRCZmZX?=
 =?utf-8?B?SU5UNmdUdHFlSlFqL21JM2NxQWI2RTZDQW91eEpSa1BiU3hiSkF1cTE1WHZ1?=
 =?utf-8?B?S1ZXbGJ4eHlGZkNIWHNRMUN2WVpucWVYaVdTcy9UTHUvVGV5SlVtWjhlMzYz?=
 =?utf-8?B?eFZVR0tQTEZoM0h1cWlmaEZOV0hTZVUwTmliTGhVQVkrQjdFbGZPK1FTWDZ3?=
 =?utf-8?B?RWlnT1Rqa0k5elJ5V0pmK0xjQzc0NkkwQzB4b0o2RkNDMnRhb0Q1US8yQmxC?=
 =?utf-8?B?SkZpMTNud2QrVmVFRTQyejNXYmFWd2ZiYk9kZVR5NURtYWtVTXNLZkZDZ3la?=
 =?utf-8?B?UzFyNzhBQWhFeStscXR5Y1VlWEpFakZsL3FwWXdiSnUrWTNpYW1vNGRJaGY3?=
 =?utf-8?B?M1R0UHF5ZTFHaGJlRnFWRGJiamt2TkRVbTh2ajlVcDBMVUdWTndZQVk3MmpJ?=
 =?utf-8?B?SUE3YVVUUnU0WFptVktMOFdsUEQyQWxKZHUxUGlxcVhrSTRaK3Q5Q2dneGhZ?=
 =?utf-8?B?R1I4WkE4aURmeG9RcXFJTkx4YnNqbk1LUUlWRElkc2JmWXJLUENDSjB5VTRh?=
 =?utf-8?B?L25SRldtd0hnL3FVbWE3bndQbUp6L2dvbUc4S3lNb08yQWtwYjlyRHk1WmQ3?=
 =?utf-8?B?K3hxTmF6ZFFmajQ1SjEwdDh6YXZ4UVNJekpNeHV5TkNNQTd4N1FURnQ3cWpC?=
 =?utf-8?Q?uA4Kz2O/YEw8z1kCD5c/LC7Rw5/mY1vz6ufASWaG6Hwju?=
X-MS-Exchange-AntiSpam-MessageData-1: DZhliXibgU0V9g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603ccf07-509d-4b5f-98a5-08ded7262247
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 04:06:31.8971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTXJy124o7t2gftbZcEdHoHmNxRMcXVQm8EEOJ0AhI6A3JavTnSbJ0tkcMzqHJ6RBMyl2OJ+ok6GoH228jt0pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9402
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

On Mon Jun 29, 2026 at 11:09 PM JST, Alexandre Courbot wrote:
> The warning emitted when the unload bundle cannot be constructed is
> valid regardless of the boot method, but it was local to `Tu102`. Move
> it to `Gsp::boot` so it applies to all boot methods.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
